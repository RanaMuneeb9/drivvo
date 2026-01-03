import 'package:drivvo/modules/more/user/user_controller.dart';
import 'package:get/get.dart';

class UserBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
  }
}
