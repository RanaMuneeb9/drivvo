import 'package:drivvo/modules/admin/home/route/update/update_route_controller.dart';
import 'package:get/get.dart';

class UpdateRouteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateRouteController>(() => UpdateRouteController());
  }
}
