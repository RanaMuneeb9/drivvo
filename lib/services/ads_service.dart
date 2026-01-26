import 'package:drivvo/utils/constants.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsService {
  static bool isAdReady = false;
  static InterstitialAd? interstitialAd;

  static void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: Constants.INTERSTITIAL_ANDROID_TEST_ID,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          isAdReady = true;
        },
        onAdFailedToLoad: (error) {
          interstitialAd = null;
          isAdReady = false;
        },
      ),
    );
  }

  static void showInterstitialAd() {
    if (isAdReady && interstitialAd != null) {
      interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          loadInterstitialAd(); // preload next ad
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          loadInterstitialAd();
        },
      );

      interstitialAd!.show();
      isAdReady = false;
    }
  }
}
