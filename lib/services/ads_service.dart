import 'dart:io';

import 'package:drivvo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsService {
  static bool isInterstitialLoaded = false;
  static InterstitialAd? interstitialAd;

  // Native Ad
  static NativeAd? nativeAd;
  static var isNativeAdLoaded = false.obs;

  static String get nativeAdUnitId => Platform.isAndroid
      ? Constants.NATIVE_ANDROID_TEST_ID
      : Constants.NATIVE_IOS_TEST_ID;

  static String get interstitialAdUnitId => Platform.isAndroid
      ? Constants.INTERSTITIAL_ANDROID_TEST_ID
      : Constants.INTERSTITIAL_IOS_TEST_ID;

  static void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          isInterstitialLoaded = true;
        },
        onAdFailedToLoad: (error) {
          interstitialAd = null;
          isInterstitialLoaded = false;
        },
      ),
    );
  }

  static void showInterstitialAd() {
    if (isInterstitialLoaded && interstitialAd != null) {
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
      isInterstitialLoaded = false;
    }
  }

  static void loadNativeAd() {
    nativeAd = createNativeAd(
      onAdLoaded: (loaded) {
        isNativeAdLoaded.value = loaded;
      },
    );
    nativeAd!.load();
  }

  static NativeAd createNativeAd({required void Function(bool) onAdLoaded}) {
    return NativeAd(
      adUnitId: nativeAdUnitId,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          debugPrint('$NativeAd loaded.');
          onAdLoaded(true);
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('$NativeAd failed to load: $error');
          ad.dispose();
          onAdLoaded(false);
        },
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: Colors.white,
        cornerRadius: 10.0,
      ),
    );
  }
}
