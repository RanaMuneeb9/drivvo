import 'package:drivvo/services/app_service.dart';
import 'package:drivvo/utils/constants.dart';
import 'package:get/get.dart';

class AboutUsController extends GetxController {
  late AppService appService;

  bool get isUrdu => Get.locale?.languageCode == Constants.URDU_LANGUAGE_CODE;

  // App Information
  final String lastUpdate = '2025-12-04';
  final String websiteUrl = 'https://www.drivo.com';
  final String facebookUrl = 'https://www.facebook.com/drivo';
  final String instagramUrl = 'https://www.instagram.com/drivo';
  final String twitterUrl = 'https://www.twitter.com/drivo';
  final String privacyPolicyUrl = 'https://www.drivo.com/privacy';
  final String termsOfUseUrl = 'https://www.drivo.com/terms';

  // Star rating
  var currentRating = 3.obs;

  @override
  void onInit() {
    appService = Get.find<AppService>();
    super.onInit();
  }

  void setRating(int rating) {
    currentRating.value = rating;
  }

  void rateApp() {}

  void openFacebook() {}

  void openInstagram() {}

  void openTwitter() {}

  void openWebsite() {}

  void openPrivacyPolicy() {}

  void openTermsOfUse() {}
}
