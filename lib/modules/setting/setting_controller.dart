import 'dart:ui';

import 'package:drivvo/services/app_service.dart';
import 'package:drivvo/utils/constants.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  late AppService appService;
  bool get isUrdu => Get.locale?.languageCode == Constants.URDU_LANGUAGE_CODE;

  // Categories Section
  var selectedTheme = 'Use system default'.obs;
  var selectedLanguage = 'English (United States)'.obs;
  var selectedDateFormat = ''.obs;
  var selectedCurrencyFormat = 'Pakistani Rupee (PKR) - Rs 1,000.00'.obs;
  var showThreeDecimalDigits = false.obs;
  var displayDecimalDigits = true.obs;

  // Units Section
  var selectedDistanceUnit = 'km'.obs;
  var selectedFuelUnit = 'Liter (L)'.obs;
  var selectedGasUnit = 'm³'.obs;
  var selectedFuelEfficiency = 'Mile/Gallon US'.obs;
  var showAverageLastRecords = false.obs;

  // Reminders Section
  var distanceInAdvance = 'Show reminder 300 km in advance.'.obs;
  var daysInAdvance = 'Show reminder 30 days in advance.'.obs;
  var bestTimeForNotifications = '10:30'.obs;
  var refuelingNotifications = true.obs;
  var tirePressureNotifications = true.obs;
  var gasStationNotifications = true.obs;
  var vibrateWhenNotifying = true.obs;

  @override
  void onInit() {
    appService = Get.find<AppService>();
    _initializeLanguage();
    super.onInit();

    selectedDateFormat.value = appService.selectedDateFormat.value;
    selectedFuelUnit.value = appService.fuelUnit.value;
    selectedGasUnit.value = appService.gasUnit.value;

    // Initialize currency format display value from AppService
    _initializeCurrencyFormat();
  }

  void _initializeCurrencyFormat() {
    final name = appService.selectedCurrencyName.value;
    final code = appService.selectedCurrencyCode.value;
    final format = appService.selectedCurrencyFormat.value;
    selectedCurrencyFormat.value = '$name ($code) - $format';
  }

  void _initializeLanguage() {
    if (isUrdu) {
      selectedLanguage.value = 'اردو (پاکستان)';
    } else {
      selectedLanguage.value = 'English (United States)';
    }
  }

  void changeLanguage(String language) {
    if (language == 'اردو (پاکستان)') {
      Get.updateLocale(const Locale('ur', 'PK'));
    } else {
      Get.updateLocale(const Locale('en', 'US'));
    }
  }

  void saveCurrencyFormat(Map<String, String> currency) {
    // Save the currency format settings to appService for app-wide usage
    appService.setCurrencyFormat(
      symbol: currency['symbol'] ?? 'Rs',
      code: currency['code'] ?? 'PKR',
      format: currency['format'] ?? 'Rs 1,000.00',
      name: currency['name'] ?? 'Pakistani Rupee',
    );
  }
}
