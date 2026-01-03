import 'package:drivvo/custom-widget/button/custom_button.dart';
import 'package:drivvo/custom-widget/text-input-field/card_text_input_field.dart';
import 'package:drivvo/modules/admin/more/user-vehicle/create/create_user_vehicle_controller.dart';
import 'package:drivvo/routes/app_routes.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateUserVehicleView extends GetView<CreateUserVehicleController> {
  const CreateUserVehicleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Utils.appColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          "vehicle/user".tr,
          style: Utils.getTextStyle(
            baseSize: 18,
            isBold: true,
            color: Colors.white,
            isUrdu: controller.isUrdu,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16.0,
              ),
              child: Form(
                key: controller.formStateKey,
                child: Column(
                  children: [
                    CardTextInputField(
                      isUrdu: controller.isUrdu,
                      isRequired: true,
                      isNext: true,
                      obscureText: false,
                      readOnly: true,
                      labelText: "user".tr,
                      hintText: "".tr,
                      controller: controller.nameController,
                      sufixIcon: Icon(Icons.keyboard_arrow_down),
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.USER_VIEW,
                          arguments: controller.nameController.text.trim(),
                        )?.then((e) {
                          if (e != null) {
                            controller.user.value = e;
                            controller.nameController.text =
                                "${controller.user.value.firstName} ${controller.user.value.lastName}";
                          }
                        });
                      },
                      onSaved: (value) {},
                      onValidate: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value == "Select user") {
                          return 'select_user_required'.tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    CardTextInputField(
                      isUrdu: controller.isUrdu,
                      isRequired: true,
                      isNext: true,
                      obscureText: false,
                      readOnly: true,
                      labelText: "vehicle".tr,
                      hintText: "".tr,
                      controller: controller.vehicleController,
                      sufixIcon: Icon(Icons.keyboard_arrow_down),
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.VEHICLES_VIEW,
                          arguments: {
                            "is_from_home": false,
                            "is_from_user": true,
                          },
                        )?.then((e) {
                          if (e != null) {
                            controller.vehicle.value = e;
                            controller.vehicleController.text =
                                controller.vehicle.value.name;
                          }
                        });
                      },
                      onSaved: (value) {},
                      onValidate: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value == "Select Vehicle") {
                          return 'select_vehicle_required'.tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 40),
                    CustomButton(
                      title: "save".tr,
                      onTap: () {
                        controller.saveData();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
