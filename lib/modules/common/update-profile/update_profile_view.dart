import 'package:drivvo/custom-widget/button/custom_button.dart';
import 'package:drivvo/custom-widget/common/custom_app_bar.dart';
import 'package:drivvo/custom-widget/common/icon_with_text.dart';
import 'package:drivvo/custom-widget/common/profile_image.dart';
import 'package:drivvo/custom-widget/text-input-field/card_text_input_field.dart';
import 'package:drivvo/custom-widget/text-input-field/text_input_field.dart';
import 'package:drivvo/modules/common/update-profile/update_profile_controller.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  const UpdateProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        name: "update_profile".tr,
        isUrdu: controller.isUrdu,
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  decoration: const BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Form(
                    key: controller.formStateKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            border: Border.all(width: 1, color: Utils.appColor),
                          ),
                          child: Column(
                            children: [
                              Center(
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Obx(
                                      () => SizedBox(
                                        width: 110,
                                        height: 110,
                                        child: ProfileImage(
                                          photoUrl: controller
                                              .appService
                                              .appUser
                                              .value
                                              .photoUrl,
                                          width: 100,
                                          height: 100,
                                          radius: 100,
                                          placeholder:
                                              "assets/images/placeholder.png",
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => Utils.showImagePicker(
                                        isUrdu: controller.isUrdu,
                                        pickFile: (path) =>
                                            controller.filePath.value = path,
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.1,
                                        height:
                                            MediaQuery.of(context).size.width *
                                            0.1,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Utils.appColor,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.edit,
                                            size:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.047,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),
                              if (controller
                                  .appService
                                  .appUser
                                  .value
                                  .firstName
                                  .isNotEmpty)
                                Text(
                                  controller.appService.appUser.value.firstName,
                                  style: Utils.getTextStyle(
                                    baseSize: 14,
                                    isBold: true,
                                    color: Colors.black,
                                    isUrdu: controller.isUrdu,
                                  ),
                                ),
                              controller
                                      .appService
                                      .appUser
                                      .value
                                      .firstName
                                      .isNotEmpty
                                  ? const SizedBox(height: 0)
                                  : const SizedBox(height: 20),
                              Text(
                                controller.appService.appUser.value.email,
                                style: Utils.getTextStyle(
                                  baseSize: 14,
                                  isBold: false,
                                  color: Colors.grey.shade500,
                                  isUrdu: controller.isUrdu,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 40),
                        IconWithText(
                          isUrdu: controller.isUrdu,
                          imagePath: "assets/images/info.png",
                          textColor: Utils.appColor,
                          title: "personal_information".tr,
                        ),
                        const SizedBox(height: 20),
                        TextInputField(
                          isUrdu: controller.isUrdu,
                          isRequired: false,
                          isNext: true,
                          obscureText: false,
                          readOnly: false,
                          initialValue:
                              controller.appService.appUser.value.firstName,
                          labelText: "first_name".tr,
                          hintText: "enter_your_first_name".tr,
                          inputAction: TextInputAction.next,
                          type: TextInputType.name,
                          onSaved: (value) {
                            value != null
                                ? controller.model.firstName = value
                                : controller.model.firstName = "";
                          },
                          onValidate: (value) {},
                        ),
                        const SizedBox(height: 16),
                        TextInputField(
                          isUrdu: controller.isUrdu,
                          isRequired: false,
                          isNext: true,
                          obscureText: false,
                          readOnly: false,
                          initialValue:
                              controller.appService.appUser.value.lastName,
                          labelText: "last_name".tr,
                          hintText: "enter_your_last_name".tr,
                          inputAction: TextInputAction.next,
                          type: TextInputType.name,
                          onSaved: (value) {
                            value != null
                                ? controller.model.lastName = value
                                : controller.model.lastName = "";
                          },
                          onValidate: (value) {},
                        ),
                        const SizedBox(height: 16),
                        TextInputField(
                          isUrdu: controller.isUrdu,
                          isRequired: false,
                          isNext: true,
                          obscureText: false,
                          readOnly: true,
                          initialValue:
                              controller.appService.appUser.value.email,
                          labelText: "email".tr,
                          hintText: "enter_your_email".tr,
                          inputAction: TextInputAction.next,
                          type: TextInputType.emailAddress,
                          onSaved: (value) => {},
                          onValidate: (value) {},
                        ),
                        const SizedBox(height: 16),
                        TextInputField(
                          isUrdu: controller.isUrdu,
                          isRequired: false,
                          isNext: true,
                          obscureText: false,
                          readOnly: false,
                          labelText: "phone_number".tr,
                          hintText: "enter_your_phone_number".tr,
                          inputAction: TextInputAction.next,
                          initialValue:
                              controller.appService.appUser.value.phone,
                          type: TextInputType.number,
                          onSaved: (value) {
                            value != null
                                ? controller.model.phone = value
                                : controller.model.phone = "";
                          },
                          onValidate: (value) {},
                        ),
                        const SizedBox(height: 30),
                        IconWithText(
                          isUrdu: controller.isUrdu,
                          imagePath: "assets/images/additional.png",
                          textColor: Utils.appColor,
                          title: "driver_license_info".tr,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: CardTextInputField(
                                isRequired: false,
                                isNext: true,
                                obscureText: false,
                                readOnly: true,
                                controller: controller.issueDateController,
                                isUrdu: controller.isUrdu,
                                labelText: "issue_date".tr,
                                hintText: "select_date".tr,
                                sufixIcon: Icon(
                                  Icons.date_range,
                                  color: Utils.appColor,
                                ),
                                onSaved: (value) {},
                                onTap: () =>
                                    controller.selectDate(isIssueDate: true),
                                onValidate: (value) => null,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: CardTextInputField(
                                isRequired: false,
                                isNext: true,
                                obscureText: false,
                                readOnly: true,
                                controller: controller.expiryDateController,
                                isUrdu: controller.isUrdu,
                                labelText: "expiry_date".tr,
                                hintText: "select_date".tr,
                                sufixIcon: Icon(
                                  Icons.date_range,
                                  color: Utils.appColor,
                                ),
                                onSaved: (value) {},
                                onTap: () =>
                                    controller.selectDate(isIssueDate: false),
                                onValidate: (value) => null,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextInputField(
                          isUrdu: controller.isUrdu,
                          isRequired: false,
                          isNext: true,
                          obscureText: false,
                          readOnly: false,
                          initialValue:
                              controller.appService.appUser.value.licenseNumber,
                          labelText: "license_number".tr,
                          hintText: "enter_your_license_number".tr,
                          inputAction: TextInputAction.next,
                          type: TextInputType.name,
                          onSaved: (value) {
                            value != null
                                ? controller.model.licenseNumber = value
                                : controller.model.licenseNumber = "";
                          },
                          onValidate: (value) {},
                        ),
                        const SizedBox(height: 16),
                        TextInputField(
                          isUrdu: controller.isUrdu,
                          isRequired: false,
                          isNext: false,
                          obscureText: false,
                          readOnly: false,
                          labelText: "category".tr,
                          hintText: "license_category".tr,
                          initialValue: controller
                              .appService
                              .appUser
                              .value
                              .licenseCategory,
                          inputAction: TextInputAction.done,
                          type: TextInputType.name,
                          onSaved: (value) {
                            value != null
                                ? controller.model.licenseCategory = value
                                : controller.model.licenseCategory = "";
                          },
                          onValidate: (value) {},
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 30.0,
                  left: 16,
                  right: 16,
                ),
                child: CustomButton(
                  title: "update".tr,
                  onTap: () => controller.saveData(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
