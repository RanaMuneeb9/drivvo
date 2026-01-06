import 'package:cloud_functions/cloud_functions.dart';
import 'package:drivvo/model/app_user.dart';
import 'package:drivvo/model/onboarding_model.dart';
import 'package:drivvo/services/app_service.dart';
import 'package:drivvo/utils/constants.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateUserController extends GetxController {
  late AppService appService;
  final formStateKey = GlobalKey<FormState>();
  bool get isUrdu => Get.locale?.languageCode == Constants.URDU_LANGUAGE_CODE;

  final issueDateController = TextEditingController();
  final expiryDateController = TextEditingController();
  final passwordController = TextEditingController();

  var showPwd = true.obs;
  // Loading state
  var isLoading = false.obs;
  var model = AppUser();

  @override
  void onInit() {
    appService = Get.find<AppService>();
    super.onInit();
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

  void onSelectUser(OnboardingModel? value) {
    if (value != null) {
      model.userType = value.title.tr;
    }
  }

  Future<void> saveUser() async {
    if (formStateKey.currentState?.validate() == true) {
      formStateKey.currentState?.save();

      Utils.showProgressDialog();

      try {
        // Verify user is authenticated before calling Cloud Function
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser == null) {
          Get.back();
          Utils.showSnackBar(message: 'error_unauthenticated', success: false);
          return;
        }
        // Force refresh the ID token to ensure it's valid
        try {
          await currentUser.getIdToken(true);
        } catch (e) {
          Get.back();
          Utils.showSnackBar(
            message: 'error_token_refresh_failed',
            success: false,
          );
          return;
        }
        if (kDebugMode) {
          print('User authenticated: ${currentUser.uid}');
          print('Email: ${currentUser.email}');
        }

        // Call the Cloud Function to create user
        // Specify the region explicitly for 2nd Gen Cloud Functions
        final HttpsCallable callable = FirebaseFunctions.instanceFor(
          region: 'us-central1',
        ).httpsCallable('createUser');

        final result = await callable.call<Map<String, dynamic>>({
          'email': model.email,
          'password': passwordController.text,
          'firstName': model.firstName,
          'lastName': model.lastName,
          'userType': model.userType,
          'adminId': appService.appUser.value.id,
        });

        final data = result.data;

        if (data['success'] == true) {
          passwordController.text = "";
          formStateKey.currentState?.reset();
          Get.back(closeOverlays: true);
          Utils.showSnackBar(message: "user_registered_success", success: true);
        } else {
          Get.back();
          Utils.showSnackBar(
            message: data['message'] ?? 'save_data_failed',
            success: false,
          );
        }
      } on FirebaseFunctionsException catch (e) {
        Get.back();
        // Handle specific error codes from the Cloud Function
        switch (e.code) {
          case 'already-exists':
            Utils.showSnackBar(message: 'email_already_in_use', success: false);
            break;
          case 'invalid-argument':
            Utils.showSnackBar(
              message: e.message ?? 'invalid_data',
              success: false,
            );
            break;
          case 'unauthenticated':
            Utils.showSnackBar(message: e.message.toString(), success: false);
            debugPrint(e.message);
            break;
          default:
            Utils.showSnackBar(message: 'save_data_failed', success: false);
        }
      } catch (e) {
        Get.back();
        Utils.showSnackBar(message: 'save_data_failed', success: false);
      }
    }
  }

  @override
  void onClose() {
    issueDateController.dispose();
    expiryDateController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
