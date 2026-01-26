import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivvo/model/app_user.dart';
import 'package:drivvo/services/app_service.dart';
import 'package:drivvo/utils/constants.dart';
import 'package:drivvo/utils/database_tables.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  late AppService appService;
  final formStateKey = GlobalKey<FormState>();
  final errorMessage = "".obs;
  final isLoading = false.obs;
  final filePath = "".obs;

  var model = AppUser();

  bool get isUrdu => Get.locale?.languageCode == Constants.URDU_LANGUAGE_CODE;
  bool get isAdmin => appService.appUser.value.userType == Constants.ADMIN;

  final FirebaseFirestore db = FirebaseFirestore.instance;

  final issueDateController = TextEditingController();
  final expiryDateController = TextEditingController();

  @override
  void onInit() {
    appService = Get.find<AppService>();
    super.onInit();

    model = appService.appUser.value;
    if (model.licenseIssueDate.isNotEmpty &&
        model.licenseExpiryDate.isNotEmpty) {
      issueDateController.text = model.licenseIssueDate;
      expiryDateController.text = model.licenseExpiryDate;
    } else {
      final now = DateTime.now();
      issueDateController.text = Utils.formatDate(date: now);
      expiryDateController.text = Utils.formatDate(
        date: now.add(Duration(days: 1)),
      );
    }
  }

  void selectDate({required bool isIssueDate}) async {
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

      if (isIssueDate) {
        issueDateController.text = date;
      } else {
        expiryDateController.text = date;
      }
    }
  }

  Future<void> saveData() async {
    if (formStateKey.currentState?.validate() == true) {
      formStateKey.currentState?.save();

      Utils.showProgressDialog();
      if (filePath.value.isNotEmpty) {
        saveUser();
      } else {
        saveUser();
      }
    }
  }

  Future<void> saveUser() async {
    String? uploadedImageUrl;
    if (filePath.value.isNotEmpty) {
      try {
        uploadedImageUrl = await Utils.uploadImage(
          collectionPath: DatabaseTables.INCOME_IMAGES,
          filePath: filePath.value,
        );
        model.photoUrl = uploadedImageUrl;
      } catch (e) {
        if (Get.isDialogOpen == true) Get.back();
        Utils.showSnackBar(message: "image_upload_failed".tr, success: false);
        return;
      }
    }

    final map = {
      "first_name": model.firstName,
      "last_name": model.lastName,
      "phone": model.phone,
      "license_number": model.licenseNumber,
      "license_category": model.licenseCategory,
      "license_issue_date": issueDateController.text.trim(),
      "license_expiry_date": expiryDateController.text.trim(),
    };

    try {
      await db
          .collection(DatabaseTables.USER_PROFILE)
          .doc(appService.appUser.value.id)
          .update(map)
          .then((_) {
            Get.back();
            Get.back();
            appService.appUser.value.firstName = model.firstName;
            appService.appUser.value.lastName = model.lastName;
            appService.appUser.value.phone = model.phone;
            appService.appUser.value.licenseNumber = model.licenseNumber;
            appService.appUser.value.licenseCategory = model.licenseCategory;
            appService.appUser.value.licenseIssueDate = model.licenseIssueDate;
            appService.appUser.value.licenseExpiryDate =
                model.licenseExpiryDate;
            appService.appUser.value.photoUrl = model.photoUrl;
            appService.appUser.refresh();
            appService.getUserProfile();
            Utils.showSnackBar(
              message: "profile_updated_success",
              success: true,
            );
          });
    } catch (e) {
      Get.back();
      Utils.showSnackBar(message: "save_data_failed", success: false);
    }
  }
}
