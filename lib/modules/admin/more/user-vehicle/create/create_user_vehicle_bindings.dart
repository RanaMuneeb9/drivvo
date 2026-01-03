import 'package:drivvo/modules/admin/more/user-vehicle/create/create_user_vehicle_controller.dart';
import 'package:get/get.dart';

class CreateUserVehicleBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateUserVehicleController>(
      () => CreateUserVehicleController(),
    );
  }
}
