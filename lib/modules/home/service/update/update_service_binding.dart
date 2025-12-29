import 'package:drivvo/modules/home/service/update/update_service_controller.dart';
import 'package:get/get.dart';

class UpdateServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateServiceController>(() => UpdateServiceController());
  }
}
