import 'package:drivvo/services/app_service.dart';
import 'package:drivvo/utils/constants.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final formStateKey = GlobalKey<FormState>();
  late AppService appService;
  TextEditingController emailController = TextEditingController();

  var email = "";

  var registeredEmail = "".obs;

  @override
  void onInit() {
    appService = Get.find<AppService>();
    super.onInit();
    registeredEmail.value = appService.appUser.value.email;
  }

  bool get isUrdu => Get.locale?.languageCode == Constants.URDU_LANGUAGE_CODE;

  
  Future<void> onTapForgot() async {
    if (formStateKey.currentState?.validate() == true) {
      formStateKey.currentState?.save();
      if (email.isNotEmpty) {
        Utils.showProgressDialog(Get.context!);
        try {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
          Get.back(closeOverlays: true);
          Utils.showSnackBar(
            message: "password_reset_link_sent",
            success: true,
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == "user-not-found") {
            Get.back(closeOverlays: true);
            Utils.showSnackBar(message: "no_user_found", success: false);
          } else if (e.code == "invalid-email") {
            Get.back(closeOverlays: true);
            Utils.showSnackBar(
              message: "invalid_email_address",
              success: false,
            );
          } else {
            Get.back(closeOverlays: true);
            Utils.showSnackBar(message: "something_went_wrong", success: false);
          }
        }
      }
    }
  }

  // Future<void> getProfile() async {
  //   var docSnapshot = await FirebaseFirestore.instance
  //       .collection(Constants.USER_PROFILE)
  //       .doc(id)
  //       .get();
  //   if (docSnapshot.exists) {
  //     Map<String, dynamic>? data = docSnapshot.data();
  //     if (data != null) {
  //       final user = AppUser.fromJson(data);
  //       registeredEmail.value = user.email;
  //     }
  //   }
  // }
}
