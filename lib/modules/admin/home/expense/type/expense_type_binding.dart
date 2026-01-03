import 'package:drivvo/modules/admin/home/expense/type/expense_type_controller.dart';
import 'package:get/get.dart';

class ExpenseTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpenseTypeController>(() => ExpenseTypeController());
  }
}
