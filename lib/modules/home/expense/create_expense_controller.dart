import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivvo/model/expense/expense_model.dart';
import 'package:drivvo/model/expense/expense_type_model.dart';
import 'package:drivvo/modules/home/home_controller.dart';
import 'package:drivvo/modules/reports/reports_controller.dart';
import 'package:drivvo/services/app_service.dart';
import 'package:drivvo/utils/constants.dart';
import 'package:drivvo/utils/database_tables.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateExpenseController extends GetxController {
  late AppService appService;
  final formKey = GlobalKey<FormState>();

  var expenseTypesList = <ExpenseTypeModel>[].obs;

  var totalAmount = 0.0.obs;
  var lastOdometer = 0.obs;

  var filePath = "".obs;
  var model = ExpenseModel().obs;

  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final expenseTypeController = TextEditingController();
  final placeController = TextEditingController();
  final paymentMethodController = TextEditingController();
  final reasonController = TextEditingController();

  bool get isUrdu => Get.locale?.languageCode == Constants.URDU_LANGUAGE_CODE;

  @override
  void onInit() {
    appService = Get.find<AppService>();
    super.onInit();
    getProfile();
    final now = DateTime.now();
    model.value.date = now;
    dateController.text = Utils.formatDate(date: now);
    timeController.text = DateFormat('hh:mm a').format(now);

    expenseTypeController.text = "select_expense_type".tr;
    placeController.text = "select_your_place".tr;
    paymentMethodController.text = "select_payment_method".tr;
    reasonController.text = "select_reason".tr;
  }

  @override
  void onClose() {
    dateController.dispose();
    timeController.dispose();
    expenseTypeController.dispose();
    placeController.dispose();
    paymentMethodController.dispose();
    reasonController.dispose();
    super.onClose();
  }

  Future<void> getProfile() async {
    await appService.getUserProfile();
    lastOdometer.value = int.parse(appService.appUser.value.lastOdometer);
  }

  void selectDate() async {
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

      dateController.text = date;
      model.value.date = picked;
    }
  }

  void selectTime() async {
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
      timeController.text = time;
      model.value.time = time;
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

  Future<void> saveRefueling() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();

      Utils.showProgressDialog(Get.context!);

      final map = {
        "user_id": appService.appUser.value.id,
        "vehicle_id": "",
        "time": timeController.text.trim(),
        "date": model.value.date,
        "odometer": model.value.odometer,
        "total_amount": totalAmount.value.toString(),
        "place": placeController.text.trim(),
        "driver_name": model.value.driverName,
        "payment_method": paymentMethodController.text.trim(),
        "reason": reasonController.text.trim(),
        "file_path": filePath.value,
        "notes": model.value.notes,
        "expense_types": expenseTypesList.map((e) => e.toJson()).toList(),
        "created_at": DateTime.now(),
      };

      try {
        await FirebaseFirestore.instance
            .collection(DatabaseTables.USER_PROFILE)
            .doc(appService.appUser.value.id)
            .set({
              'expense_list': FieldValue.arrayUnion([map]),
            }, SetOptions(merge: true))
            .then((e) async {
              //!Update last Odometer
              await FirebaseFirestore.instance
                  .collection(DatabaseTables.USER_PROFILE)
                  .doc(appService.appUser.value.id)
                  .update({"last_odometer": model.value.odometer});

              if (Get.isDialogOpen == true) Get.back();
              Get.back();

              Utils.showSnackBar(message: "expense_added".tr, success: true);
              final home = Get.find<HomeController>();
              home.loadTimelineData();

              final report = Get.find<ReportsController>();
              report.calculateAllReports();
            })
            .catchError((e) {
              if (Get.isDialogOpen == true) Get.back();
              Utils.showSnackBar(message: "something_wrong".tr, success: false);
            });

        await FirebaseFirestore.instance
            .collection(DatabaseTables.USER_PROFILE)
            .doc(appService.appUser.value.id)
            .collection(DatabaseTables.EXPENSES)
            .doc()
            .set(map);
      } catch (e) {
        if (Get.isDialogOpen == true) Get.back();

        Utils.showSnackBar(message: "something_wrong".tr, success: false);
      }
    }
  }

  void removeItem(int index) {
    if (index < 0 || index >= expenseTypesList.length) return;
    expenseTypesList.removeAt(index);
    calculateTotal();
    expenseTypesList.refresh();
  }

  void calculateTotal() {
    totalAmount.value = expenseTypesList
        .where((e) => e.isChecked.value)
        .fold(0.0, (a1, e) => a1 + (double.tryParse(e.value.value) ?? 0));
  }
}
