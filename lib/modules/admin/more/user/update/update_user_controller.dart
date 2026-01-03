import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivvo/model/app_user.dart';
import 'package:drivvo/model/onboarding_model.dart';
import 'package:drivvo/services/app_service.dart';
import 'package:drivvo/utils/constants.dart';
import 'package:drivvo/utils/database_tables.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateUserController extends GetxController {
  late AppService appService;
  final formStateKey = GlobalKey<FormState>();
  bool get isUrdu => Get.locale?.languageCode == Constants.URDU_LANGUAGE_CODE;

  // Loading state
  var isLoading = false.obs;
  var model = AppUser();

  @override
  void onInit() {
    appService = Get.find<AppService>();
    super.onInit();
    model = Get.arguments as AppUser;
  }

  void onSelectUser(OnboardingModel? value) {
    if (value != null) {
      model.userType = value.title.tr;
    }
  }

  Future<void> updateUser() async {
    if (formStateKey.currentState?.validate() == true) {
      formStateKey.currentState?.save();

      Utils.showProgressDialog();

      try {
        final userId = model.id;
        if (userId.isEmpty) {
          Get.back();
          Utils.showSnackBar(
            message: 'something_went_wrong'.tr,
            success: false,
          );
          return;
        }

        final map = <String, dynamic>{};
        map["first_name"] = model.firstName;
        map["last_name"] = model.lastName;
        map["user_type"] = model.userType;

        await FirebaseFirestore.instance
            .collection(DatabaseTables.USER_PROFILE)
            .doc(userId)
            .update(map);

        Get.back(closeOverlays: true);
        Utils.showSnackBar(
          message: 'user_updated_successfully'.tr,
          success: true,
        );
      } catch (e) {
        Get.back();
        Utils.showSnackBar(message: 'something_went_wrong'.tr, success: false);
      }
    }
  }
}
