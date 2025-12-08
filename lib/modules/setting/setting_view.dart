import 'package:drivvo/custom-widget/common/custom_app_bar.dart';
import 'package:drivvo/modules/setting/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        name: "setting".tr,
        isUrdu: controller.isUrdu,
        centerTitle: true,
        arrowColor: Colors.black,
      ),
    );
  }
}
