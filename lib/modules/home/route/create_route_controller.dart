import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivvo/model/route/route_model.dart';
import 'package:drivvo/modules/home/home_controller.dart';
import 'package:drivvo/services/app_service.dart';
import 'package:drivvo/utils/constants.dart';
import 'package:drivvo/utils/database_tables.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateRouteController extends GetxController {
  final formKey = GlobalKey<FormState>();

  late AppService appService;

  var filePath = "".obs;
  var lastOdometer = 0.obs;
  var model = RouteModel().obs;

  var initalOdometer = 0.obs;

  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final reasonController = TextEditingController();
  final originController = TextEditingController();
  final destinationController = TextEditingController();

  bool get isUrdu => Get.locale?.languageCode == Constants.URDU_LANGUAGE_CODE;

  @override
  void onInit() {
    appService = Get.find<AppService>();
    super.onInit();
    getProfile();
    final now = DateTime.now();
    model.value.startDate = now;
    model.value.endDate = now.add(Duration(days: 1));
    startDateController.text = Utils.formatDate(date: now);
    startTimeController.text = DateFormat('hh:mm a').format(now);
    endDateController.text = Utils.formatDate(date: now.add(Duration(days: 1)));
    endTimeController.text = DateFormat('hh:mm a').format(now);

    reasonController.text = "select_reason".tr;
    originController.text = "select_origin".tr;
    destinationController.text = "select_destination".tr;
  }

  @override
  void onClose() {
    startDateController.dispose();
    startTimeController.dispose();
    endDateController.dispose();
    endTimeController.dispose();
    reasonController.dispose();
    originController.dispose();
    destinationController.dispose();
    super.onClose();
  }

  Future<void> getProfile() async {
    await appService.getUserProfile();
    lastOdometer.value =
        int.tryParse(appService.appUser.value.lastOdometer) ?? 0;
  }

  void onSelectReason(String? reason) {
    if (reason != null) {
      model.value.reason = reason;
    }
  }

  void selectDate({required bool isStartDate}) async {
    final context = Get.context;
    if (context == null) return;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final date = Utils.formatDate(date: picked);

      if (isStartDate) {
        startDateController.text = date;
        model.value.startDate = picked;
      } else {
        endDateController.text = date;
        model.value.endDate = picked;
      }
    }
  }

  void selectTime({required bool isStartTime}) async {
    final context = Get.context;
    if (context == null) return;

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final now = DateTime.now();
      final dt = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );
      final time = DateFormat('hh:mm a').format(dt);

      if (isStartTime) {
        startTimeController.text = time;
        model.value.startTime = time;
      } else {
        endTimeController.text = time;
        model.value.endTime = time;
      }
    }
  }

  Future<void> onPickedFile(XFile? pickedFile) async {
    if (pickedFile != null) {
      try {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Utils.appColor,
              toolbarWidgetColor: Colors.white,
              lockAspectRatio: true,
              aspectRatioPresets: [CropAspectRatioPreset.square],
            ),
            IOSUiSettings(
              title: 'Cropper',
              aspectRatioPresets: [
                CropAspectRatioPreset
                    .square, // IMPORTANT: iOS supports only one custom aspect ratio in preset list
              ],
            ),
          ],
        );
        if (croppedFile != null) {
          filePath.value = croppedFile.path;
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future<void> saveRoute() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();

      Utils.showProgressDialog(Get.context!);

      final map = {
        "user_id": appService.appUser.value.id,
        "vehicle_id": appService.currentVehicleId.value,
        "origin": originController.text.trim(),
        "start_date": model.value.startDate,
        "start_time": startTimeController.text.trim(),
        "end_date": model.value.endDate,
        "end_time": endTimeController.text.trim(),
        "initial_odometer": model.value.initialOdometer,
        "destination": destinationController.text.trim(),
        "final_odometer": model.value.finalOdometer,
        "value_per_km": model.value.valuePerKm,
        "total": model.value.total,
        "driver_name": model.value.driverName,
        "reason": reasonController.text.trim(),
        "file_path": filePath.value,
        "notes": model.value.notes,
      };

      try {
        await FirebaseFirestore.instance
            .collection(DatabaseTables.USER_PROFILE)
            .doc(appService.appUser.value.id)
            .set({
              'route_list': FieldValue.arrayUnion([map]),
            }, SetOptions(merge: true))
            .then((e) async {
              //!Update last Odometer
              await FirebaseFirestore.instance
                  .collection(DatabaseTables.USER_PROFILE)
                  .doc(appService.appUser.value.id)
                  .update({"last_odometer": model.value.finalOdometer});
              if (Get.isDialogOpen == true) Get.back();
              Get.back();

              Utils.showSnackBar(message: "route_added".tr, success: true);
              if (Get.isRegistered<HomeController>()) {
                Get.find<HomeController>().loadTimelineData(forceFetch: true);
              }
              ;
            })
            .catchError((e) {
              if (Get.isDialogOpen == true) Get.back();
              Utils.showSnackBar(message: "something_wrong".tr, success: false);
            });
      } catch (e) {
        if (Get.isDialogOpen == true) Get.back();
        Utils.showSnackBar(message: "something_wrong".tr, success: false);
      }
    }
  }
}
