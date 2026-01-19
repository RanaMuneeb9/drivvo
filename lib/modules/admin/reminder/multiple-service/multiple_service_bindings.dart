import 'package:drivvo/modules/admin/reminder/multiple-service/multiple_service_controller.dart';
import 'package:get/get.dart';

class MultipleServiceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MultipleServiceController>(() => MultipleServiceController());
  }
}
