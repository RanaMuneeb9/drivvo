import 'package:drivvo/modules/home/expense/update/update_expense_controller.dart';
import 'package:get/get.dart';

class UpdateExpenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateExpenseController>(() => UpdateExpenseController());
  }
}
