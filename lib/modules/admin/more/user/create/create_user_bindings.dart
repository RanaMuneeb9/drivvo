import 'package:drivvo/modules/admin/more/user/create/create_user_controller.dart';
import 'package:get/get.dart';

class CreateUserBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateUserController>(() => CreateUserController());
  }
}
