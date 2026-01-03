import 'package:drivvo/modules/admin/home/refueling/update/update_refueling_controller.dart';
import 'package:get/get.dart';

class UpdateRefuelingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateRefuelingController>(() => UpdateRefuelingController());
  }
}
