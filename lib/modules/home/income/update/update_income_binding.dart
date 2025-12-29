import 'package:drivvo/modules/home/income/update/update_income_controller.dart';
import 'package:get/get.dart';

class UpdateIncomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateIncomeController>(() => UpdateIncomeController());
  }
}
