import 'package:drivvo/modules/admin/more/vehicles/update/update_vehicles_controller.dart';
import 'package:get/get.dart';

class UpdateVehiclesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateVehiclesController>(() => UpdateVehiclesController());
  }
}
