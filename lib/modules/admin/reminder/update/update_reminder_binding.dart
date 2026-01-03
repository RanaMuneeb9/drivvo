import 'package:drivvo/modules/admin/reminder/update/update_reminder_controller.dart';
import 'package:get/get.dart';

class UpdateReminderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateReminderController>(() => UpdateReminderController());
  }
}
