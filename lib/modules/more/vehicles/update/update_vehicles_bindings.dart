import 'package:drivvo/modules/more/vehicles/update/update_vehicles_controller.dart';
import 'package:get/get.dart';

class UpdateVehiclesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateVehiclesController>(() => UpdateVehiclesController());
  }
}
