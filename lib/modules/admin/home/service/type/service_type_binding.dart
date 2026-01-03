import 'package:drivvo/modules/admin/home/service/type/service_type_controller.dart';
import 'package:get/get.dart';

class ServiceTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceTypeController>(() => ServiceTypeController());
  }
}
