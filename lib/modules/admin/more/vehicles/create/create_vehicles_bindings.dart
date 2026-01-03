import 'package:drivvo/modules/admin/more/vehicles/create/create_vehicles_controller.dart';
import 'package:get/get.dart';

class CreateVehiclesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateVehiclesController>(() => CreateVehiclesController());
  }
}
