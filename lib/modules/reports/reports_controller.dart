import 'package:drivvo/services/app_service.dart';
import 'package:drivvo/utils/constants.dart';
import 'package:get/get.dart';

class ReportsController extends GetxController {
  late AppService appService;
  bool get isUrdu => Get.locale?.languageCode == Constants.URDU_LANGUAGE_CODE;

  final list = ["General", "Refueling", "Expense", "Income", "Service"];
  var selectedName = "General".obs;

  @override
  void onInit() {
    appService = Get.find<AppService>();
    super.onInit();
  }

  void onSelect(String name) {
    selectedName.value = name;
  }
}
