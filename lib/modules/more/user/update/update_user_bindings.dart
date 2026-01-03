import 'package:drivvo/modules/more/user/update/update_user_controller.dart';
import 'package:get/get.dart';

class UpdateUserBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateUserController>(() => UpdateUserController());
  }
}
