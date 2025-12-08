import 'package:drivvo/custom-widget/common/custom_app_bar.dart';
import 'package:drivvo/custom-widget/text-input-field/text_input_field.dart';
import 'package:drivvo/modules/more/general/create/create_general_controller.dart';
import 'package:drivvo/utils/constants.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateGeneralView extends GetView<CreateGeneralController> {
  const CreateGeneralView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        name: controller.isUrdu
            ? "${controller.title.tr} ${"add".tr}"
            : "${"add".tr} ${controller.title.tr}",
        isUrdu: controller.isUrdu,
        bgColor: Utils.appColor,
        textColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => controller.saveData(),
            icon: Text(
              "save".tr,
              style: Utils.getTextStyle(
                baseSize: 16,
                isBold: true,
                color: Colors.white,
                isUrdu: controller.isUrdu,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (controller.title == Constants.EXPENSE_TYPES)
              Form(
                key: controller.formStateKey,
                child: TextInputField(
                  isUrdu: controller.isUrdu,
                  isRequired: true,
                  isNext: true,
                  obscureText: false,
                  readOnly: false,
                  labelText: "type".tr,
                  hintText: "name".tr,
                  inputAction: TextInputAction.next,
                  type: TextInputType.name,
                  onTap: () {},
                  onSaved: (value) {
                    controller.name = value!;
                  },
                  onValidate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'expense_type_required'.tr;
                    }
                    return null;
                  },
                ),
              ),

            if (controller.title == Constants.INCOME_TYPES)
              Form(
                key: controller.formStateKey,
                child: TextInputField(
                  isUrdu: controller.isUrdu,
                  isRequired: true,
                  isNext: true,
                  obscureText: false,
                  readOnly: false,
                  labelText: "type".tr,
                  hintText: "name".tr,
                  inputAction: TextInputAction.next,
                  type: TextInputType.name,
                  onTap: () {},
                  onSaved: (value) {
                    controller.name = value!;
                  },
                  onValidate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'income_type_required'.tr;
                    }
                    return null;
                  },
                ),
              ),

            if (controller.title == Constants.SERVICE_TYPES)
              Form(
                key: controller.formStateKey,
                child: TextInputField(
                  isUrdu: controller.isUrdu,
                  isRequired: true,
                  isNext: true,
                  obscureText: false,
                  readOnly: false,
                  labelText: "type".tr,
                  hintText: "name".tr,
                  inputAction: TextInputAction.next,
                  type: TextInputType.name,
                  onTap: () {},
                  onSaved: (value) {
                    controller.name = value!;
                  },
                  onValidate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'service_type_required'.tr;
                    }
                    return null;
                  },
                ),
              ),

            if (controller.title == Constants.PAYMENT_METHOD)
              Form(
                key: controller.formStateKey,
                child: TextInputField(
                  isUrdu: controller.isUrdu,
                  isRequired: true,
                  isNext: true,
                  obscureText: false,
                  readOnly: false,
                  labelText: "method_name".tr,
                  hintText: "name".tr,
                  inputAction: TextInputAction.next,
                  type: TextInputType.name,
                  onTap: () {},
                  onSaved: (value) {
                    controller.name = value!;
                  },
                  onValidate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'payment_method_required'.tr;
                    }
                    return null;
                  },
                ),
              ),

            if (controller.title == Constants.REASONS)
              Form(
                key: controller.formStateKey,
                child: TextInputField(
                  isUrdu: controller.isUrdu,
                  isRequired: true,
                  isNext: true,
                  obscureText: false,
                  readOnly: false,
                  labelText: "reason".tr,
                  hintText: "enter_your_reason".tr,
                  inputAction: TextInputAction.next,
                  type: TextInputType.name,
                  onTap: () {},
                  onSaved: (value) {
                    controller.name = value!;
                  },
                  onValidate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'reason_required'.tr;
                    }
                    return null;
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
