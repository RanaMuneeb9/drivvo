import 'package:drivvo/modules/home/service/create_service_controller.dart';
import 'package:get/get.dart';

class CreateServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateServiceController>(() => CreateServiceController());
  }
}
