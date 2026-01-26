import 'dart:io';

import 'package:drivvo/routes/app_routes.dart';
import 'package:drivvo/services/app_service.dart';
import 'package:drivvo/utils/constants.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreController extends GetxController {
  late AppService appService;
  var currentLanguage = "english".obs;
  bool get isUrdu => Get.locale?.languageCode == Constants.URDU_LANGUAGE_CODE;

  var registeredVehicles = 0.obs;

  @override
  void onInit() {
    appService = Get.find<AppService>();
    super.onInit();

    // Load saved language
    final savedLanguageCode = appService.savedLanguage;
    if (savedLanguageCode == 'ur') {
      currentLanguage.value = "urdu";
    } else {
      currentLanguage.value = "english";
    }
  }

  Future<void> onPremiumPlanTap() async {
    if (appService.appUser.value.isSubscribed) {
      if (Platform.isIOS) {
        // final Uri url = Uri.parse(Constants.APP_STORE_URL);
        // if (await canLaunchUrl(url)) {
        //   await launchUrl(url, mode: LaunchMode.externalApplication);
        // }
        Get.toNamed(AppRoutes.PLAN_VIEW);
      } else {
        final Uri url = Uri.parse(Constants.PLAY_STORE_URL);
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
      }
    } else {
      Get.toNamed(AppRoutes.PLAN_VIEW);
    }
  }
}
