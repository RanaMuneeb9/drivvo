import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivvo/model/refueling/refueling_model.dart';
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

class CreateRefuelingController extends GetxController {
  String? _lastEditedField;
  final formKey = GlobalKey<FormState>();

  late AppService appService;

  var filePath = "".obs;
  var isFullTank = false.obs;
  var model = RefuelingModel().obs;
  var moreOptionsExpanded = false.obs;
  var missedPreviousRefueling = false.obs;

  var lastOdometer = 0.obs;

  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final priceController = TextEditingController();
  final fuelController = TextEditingController();
  final litersController = TextEditingController();
  final totalCostController = TextEditingController();
  final gasStationCostController = TextEditingController();
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

    fuelController.text = "select_fuel".tr;
    gasStationCostController.text = "select_gas_station".tr;
    paymentMethodController.text = "select_payment_method".tr;
    reasonController.text = "select_reason".tr;
  }

  @override
  void onClose() {
    dateController.dispose();
    timeController.dispose();
    priceController.dispose();
    totalCostController.dispose();
    litersController.dispose();
    fuelController.dispose();
    gasStationCostController.dispose();
    paymentMethodController.dispose();
    reasonController.dispose();
    super.onClose();
  }

  Future<void> getProfile() async {
    await appService.getUserProfile();
    lastOdometer.value =
        int.tryParse(appService.appUser.value.lastOdometer) ?? 0;
  }

  // Called when user changes price value
  void onPriceChanged(String? value) {
    if (value == null || value.isEmpty) return;
    final price = double.tryParse(value);
    if (price == null) return;

    model.value.price = price.toInt().toString();
    _lastEditedField = 'price';
    calculateThirdValue();
  }

  // Called when user changes total cost value
  void onTotalCostChanged(String? value) {
    if (value == null || value.isEmpty) return;
    final totalCost = double.tryParse(value);
    if (totalCost == null) return;

    model.value.totalCost = totalCost.toInt().toString();
    _lastEditedField = 'totalCost';
    calculateThirdValue();
  }

  // Called when user changes liters value
  void onLitersChanged(String? value) {
    if (value == null || value.isEmpty) return;
    final liter = double.tryParse(value);
    if (liter == null) return;

    model.value.liter = liter.toInt().toString();
    _lastEditedField = 'liter';
    calculateThirdValue();
  }

  void calculateThirdValue() {
    final price = double.tryParse(model.value.price) ?? 0.0;
    final totalCost = double.tryParse(model.value.totalCost) ?? 0.0;
    final liter = double.tryParse(model.value.liter) ?? 0.0;
    //Formula: totalCost = price * liter
    // If price and totalCost are entered, calculate liters
    if (_lastEditedField != 'liter' && price > 0 && totalCost > 0) {
      final calculatedLiter = totalCost / price;
      model.value.liter = calculatedLiter.toString();
      litersController.text = calculatedLiter.toStringAsFixed(2);
    }
    // If price and liters are entered, calculate totalCost
    else if (_lastEditedField != 'totalCost' && price > 0 && liter > 0) {
      final calculatedTotalCost = price * liter;
      model.value.totalCost = calculatedTotalCost.toString();
      totalCostController.text = calculatedTotalCost.toStringAsFixed(2);

      final currencyFormat = NumberFormat.currency(symbol: '');
      totalCostController.text = currencyFormat.format(calculatedTotalCost);
    }
    // If totalCost and liters are entered, calculate price
    else if (_lastEditedField != 'price' && totalCost > 0 && liter > 0) {
      final calculatedPrice = totalCost / liter;
      model.value.price = calculatedPrice.toString();
      priceController.text = calculatedPrice.toStringAsFixed(2);
    }
  }

  void toggleMoreOptions() {
    moreOptionsExpanded.value = !moreOptionsExpanded.value;
  }

  void onSelectFuelType(String? type) {
    if (type != null) {
      model.value.fuelType = type;
    }
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
        "id": appService.appUser.value.id,
        "vehicle_id": "",
        "time": timeController.text.trim(),
        "date": model.value.date,
        "odometer": model.value.odometer,
        "price": priceController.text.trim(),
        "liter": litersController.text.trim(),
        "total_cost": totalCostController.text.trim(),
        "fuel_type": fuelController.text.trim(),
        "fuel_station": gasStationCostController.text.trim(),
        "full_tank": isFullTank.value,
        "missed_previous": missedPreviousRefueling.value,
        "payment_method": paymentMethodController.text.trim(),
        "notes": model.value.notes,
        "driver_name": model.value.driverName,
        "created_at": DateTime.now(),
      };

      try {
        // await FirebaseFirestore.instance
        //     .collection(DatabaseTables.USER_PROFILE)
        //     .doc(appService.appUser.value.id)
        //     .collection(DatabaseTables.REFUELING)
        //     .doc()
        //     .set(map);

        // await FirebaseFirestore.instance
        //     .collection(DatabaseTables.USER_PROFILE)
        //     .doc(appService.appUser.value.id)
        //     .set({
        //       'refueling_list': FieldValue.arrayUnion([map]),
        //     }, SetOptions(merge: true))
        //     .then((e) async {
        //       //!Update last Odometer
        //       await FirebaseFirestore.instance
        //           .collection(DatabaseTables.USER_PROFILE)
        //           .doc(appService.appUser.value.id)
        //           .update({"last_odometer": model.value.odometer});

        //       if (Get.isDialogOpen == true) Get.back();
        //       Get.back();

        //       Utils.showSnackBar(message: "refueling_added".tr, success: true);

        //       if (Get.isRegistered<HomeController>()) {
        //         Get.find<HomeController>().loadTimelineData();
        //       }

        //       if (Get.isRegistered<ReportsController>()) {
        //         Get.find<ReportsController>().calculateAllReports();
        //       }
        //     })
        //     .catchError((e) {
        //       if (Get.isDialogOpen == true) Get.back();
        //       Utils.showSnackBar(message: "something_wrong".tr, success: false);
        //     });

        final batch = FirebaseFirestore.instance.batch();
        final docRef = FirebaseFirestore.instance
            .collection(DatabaseTables.USER_PROFILE)
            .doc(appService.appUser.value.id);

        batch.set(docRef, {
          'refueling_list': FieldValue.arrayUnion([map]),
        }, SetOptions(merge: true));

        batch.update(docRef, {"last_odometer": model.value.odometer});

        await batch.commit();

        if (Get.isDialogOpen == true) Get.back();
        Get.back();

        Utils.showSnackBar(message: "refueling_added".tr, success: true);

        if (Get.isRegistered<HomeController>()) {
          Get.find<HomeController>().loadTimelineData();
        }

        if (Get.isRegistered<ReportsController>()) {
          Get.find<ReportsController>().calculateAllReports();
        }
      } catch (e) {
        if (Get.isDialogOpen == true) Get.back();
        Utils.showSnackBar(message: "something_wrong".tr, success: false);
      }
    }
  }
}
