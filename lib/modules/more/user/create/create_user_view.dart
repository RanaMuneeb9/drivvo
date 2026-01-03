import 'package:drivvo/custom-widget/button/custom_button.dart';
import 'package:drivvo/custom-widget/text-input-field/form_label_text.dart';
import 'package:drivvo/custom-widget/text-input-field/password_input_field.dart';
import 'package:drivvo/custom-widget/text-input-field/text_input_field.dart';
import 'package:drivvo/model/onboarding_model.dart';
import 'package:drivvo/modules/more/user/create/create_user_controller.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateUserView extends GetView<CreateUserController> {
  const CreateUserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Utils.appColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'create_user'.tr,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Form(
                key: controller.formStateKey,
                child: Column(
                  children: [
                    TextInputField(
                      isUrdu: controller.isUrdu,
                      isRequired: true,
                      isNext: true,
                      obscureText: false,
                      readOnly: false,
                      labelText: "first_name".tr,
                      hintText: "enter_first_name".tr,
                      inputAction: TextInputAction.next,
                      type: TextInputType.name,
                      onChange: (value) {},
                      onSaved: (value) {
                        if (value != null) {
                          controller.model.firstName = value;
                        }
                      },
                      onValidate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'first_name_required'.tr;
                        } else if (value.length < 3) {
                          return "invalid_name".tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextInputField(
                      isUrdu: controller.isUrdu,
                      isRequired: false,
                      isNext: true,
                      obscureText: false,
                      readOnly: false,
                      labelText: "last_name".tr,
                      hintText: "enter_last_name".tr,
                      inputAction: TextInputAction.next,
                      type: TextInputType.name,
                      onChange: (value) {},
                      onSaved: (value) {
                        if (value != null) {
                          controller.model.lastName = value;
                        }
                      },
                      onValidate: (value) => null,
                    ),
                    const SizedBox(height: 16),
                    FormLabelText(
                      title: "user_type".tr,
                      isUrdu: controller.isUrdu,
                    ),
                    const SizedBox(height: 4),
                    DropdownButtonFormField<OnboardingModel>(
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      items: Utils.userTypeList
                          .map<DropdownMenuItem<OnboardingModel>>((element) {
                            return DropdownMenuItem<OnboardingModel>(
                              value: element,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    element.title.tr,
                                    style: Utils.getTextStyle(
                                      baseSize: 14,
                                      isBold: false,
                                      color: Colors.black,
                                      isUrdu: controller.isUrdu,
                                    ),
                                  ),
                                  Text(
                                    element.description.tr,
                                    style: Utils.getTextStyle(
                                      baseSize: 13,
                                      isBold: false,
                                      color: Colors.black45,
                                      isUrdu: controller.isUrdu,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            );
                          })
                          .toList(),
                      // Selected item view (ONLY title)
                      selectedItemBuilder: (context) {
                        return Utils.userTypeList.map((element) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              element.title.tr,
                              style: Utils.getTextStyle(
                                baseSize: 14,
                                isBold: false,
                                color: Colors.black,
                                isUrdu: controller.isUrdu,
                              ),
                            ),
                          );
                        }).toList();
                      },

                      onChanged: (OnboardingModel? value) =>
                          value != null ? controller.onSelectUser(value) : null,
                      validator: (value) {
                        if (value == null) {
                          return "user_type_required".tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    TextInputField(
                      isUrdu: controller.isUrdu,
                      isRequired: true,
                      isNext: true,
                      obscureText: false,
                      readOnly: false,
                      labelText: "email".tr,
                      hintText: "enter_email".tr,
                      inputAction: TextInputAction.next,
                      type: TextInputType.emailAddress,
                      onChange: (value) {},
                      onSaved: (value) {
                        if (value != null) {
                          controller.model.email = value;
                        }
                      },
                      onValidate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'email_required'.tr;
                        }

                        const emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$';
                        final regex = RegExp(emailPattern);

                        if (!regex.hasMatch(value)) {
                          return 'enter_valid_email'.tr;
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => PasswordInputField(
                        isRequired: true,
                        isNext: true,
                        obscureText: controller.showPwd.value,
                        readOnly: false,
                        isUrdu: controller.isUrdu,
                        labelText: "password".tr,
                        hintText: "enter_your_password".tr,
                        inputAction: TextInputAction.next,
                        type: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                          onPressed: () => controller.showPwd.value =
                              !controller.showPwd.value,
                          icon: Icon(
                            controller.showPwd.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        onChanged: (value) {},
                        onPessed: () {},
                        onSaved: (value) {
                          if (value != null) {
                            controller.passwordController.text = value;
                          }
                        },
                        onValidate: (value) => value!.isEmpty
                            ? 'password_required'.tr
                            : value.length < 8
                            ? "password_short".tr
                            : null,
                      ),
                    ),
                    const SizedBox(height: 40),
                    CustomButton(
                      title: "create".tr,
                      onTap: () {
                        controller.saveUser();
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
