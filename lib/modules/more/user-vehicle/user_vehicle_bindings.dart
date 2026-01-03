import 'package:drivvo/modules/more/user-vehicle/user_vehicle_controller.dart';
import 'package:get/get.dart';

class UserVehicleBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserVehicleController>(() => UserVehicleController());
  }
}
