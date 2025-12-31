import 'package:drivvo/modules/more/about_us/about_us_controller.dart';
import 'package:get/get.dart';

class AboutUsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutUsController>(() => AboutUsController());
  }
}
