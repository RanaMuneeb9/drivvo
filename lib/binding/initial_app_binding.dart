import 'package:drivvo/services/iap_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitialAppBinding extends Bindings {
  @override
  void dependencies() {
    // Inject IAPService immediately so it's available in Login/Splash
    try {
      Get.put(IAPService(), permanent: true);
    } catch (e) {
      // Log the error and optionally inject a stub/fallback implementation
      debugPrint('Failed to initialize IAPService: $e');
      // Consider: Get.put(IAPServiceStub(), permanent: true);
    }
  }
}
