import 'package:drivvo/modules/admin/home/home_controller.dart';
import 'package:drivvo/modules/admin/more/more_controller.dart';
import 'package:drivvo/modules/admin/reminder/reminder_controller.dart';
import 'package:drivvo/modules/admin/reports/reports_controller.dart';
import 'package:drivvo/modules/admin/root/root_controller.dart';
import 'package:get/get.dart';

class RootBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootController>(() => RootController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ReportsController>(() => ReportsController());
    Get.lazyPut<ReminderController>(() => ReminderController());
    Get.lazyPut<MoreController>(() => MoreController());
  }
}
