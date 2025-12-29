import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivvo/model/expense/expense_type_model.dart';
import 'package:drivvo/model/service/service_model.dart';
import 'package:drivvo/modules/home/home_controller.dart';
import 'package:drivvo/modules/reports/reports_controller.dart';
import 'package:drivvo/services/app_service.dart';
import 'package:drivvo/utils/constants.dart';
import 'package:drivvo/utils/database_tables.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateServiceController extends GetxController {
  late AppService appService;
  final formKey = GlobalKey<FormState>();

  var serviceTyesList = <ExpenseTypeModel>[].obs;

  var totalAmount = 0.obs;
  var lastOdometer = 0.obs;

  var filePath = "".obs;
  var model = ServiceModel().obs;

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
    final now = DateTime.now();
    model.value.date = now;
    dateController.text = Utils.formatDate(date: now);
    timeController.text = DateFormat('hh:mm a').format(now);

    expenseTypeController.text = "select_expense_type".tr;
    placeController.text = "select_your_place".tr;
    paymentMethodController.text = "select_payment_method".tr;
    reasonController.text = "select_reason".tr;

    lastOdometer.value = appService.appUser.value.lastOdometer;
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

  Future<void> saveService() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();

      Utils.showProgressDialog();

      final map = {
        "user_id": appService.appUser.value.id,
        "vehicle_id": appService.currentVehicleId.value,
        "time": timeController.text.trim(),
        "date": model.value.date,
        "odometer": model.value.odometer,
        "total_amount": totalAmount.value,
        "place": placeController.text.trim(),
        "driver_name": model.value.driverName,
        "payment_method": paymentMethodController.text.trim(),
        "reason": reasonController.text.trim(),
        "file_path": filePath.value,
        "notes": model.value.notes,
        "expense_types": serviceTyesList.map((e) => e.toJson()).toList(),
        "created_at": DateTime.now(),
      };

      try {
        final batch = FirebaseFirestore.instance.batch();
        final docRef = FirebaseFirestore.instance
            .collection(DatabaseTables.USER_PROFILE)
            .doc(appService.appUser.value.id);

        // Single atomic operation
        batch.set(docRef, {
          'service_list': FieldValue.arrayUnion([map]),
        }, SetOptions(merge: true));

        batch.update(docRef, {"last_odometer": model.value.odometer});

        await batch.commit();

        if (Get.isDialogOpen == true) Get.back();
        Get.back();

        Utils.showSnackBar(message: "service_added".tr, success: true);

        // await appService.getUserProfile();

        if (Get.isRegistered<HomeController>()) {
          Get.find<HomeController>().loadTimelineData(forceFetch: true);
        }

        if (Get.isRegistered<ReportsController>()) {
          Get.find<ReportsController>().calculateAllReports();
        }
      } on FirebaseException catch (e) {
        Utils.getFirebaseException(e);
      } catch (e) {
        if (Get.isDialogOpen == true) Get.back();
        Utils.showSnackBar(message: "something_wrong".tr, success: false);
      }
    }
  }

  void removeItem(int index) {
    if (index < 0 || index >= serviceTyesList.length) return;
    serviceTyesList.removeAt(index);
    calculateTotal();
    serviceTyesList.refresh();
  }

  void calculateTotal() {
    totalAmount.value = serviceTyesList
        .where((e) => e.isChecked.value)
        .fold(0, (a1, e) => a1 + e.value.value);
  }
}
