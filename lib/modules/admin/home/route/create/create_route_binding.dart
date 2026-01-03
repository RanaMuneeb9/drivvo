import 'package:drivvo/modules/admin/home/route/create/create_route_controller.dart';
import 'package:get/get.dart';

class CreateRouteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateRouteController>(() => CreateRouteController());
  }
}
