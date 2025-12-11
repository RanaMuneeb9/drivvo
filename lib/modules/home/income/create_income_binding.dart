import 'package:drivvo/modules/home/income/create_income_controller.dart';
import 'package:get/get.dart';

class CreateIncomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateIncomeController>(() => CreateIncomeController());
  }
}
