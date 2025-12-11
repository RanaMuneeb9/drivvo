import 'package:drivvo/modules/home/route/create_route_controller.dart';
import 'package:get/get.dart';

class CreateRouteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateRouteController>(() => CreateRouteController());
  }
}
