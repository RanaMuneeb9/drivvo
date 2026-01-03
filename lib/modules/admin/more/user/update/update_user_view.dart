import 'package:drivvo/custom-widget/button/custom_button.dart';
import 'package:drivvo/custom-widget/text-input-field/form_label_text.dart';
import 'package:drivvo/custom-widget/text-input-field/text_input_field.dart';
import 'package:drivvo/model/onboarding_model.dart';
import 'package:drivvo/modules/admin/more/user/update/update_user_controller.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateUserView extends GetView<UpdateUserController> {
  const UpdateUserView({super.key});

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
          'update_user'.tr,
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
                      initialValue: controller.model.firstName,
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
                      initialValue: controller.model.lastName,
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
                      value: Utils.userTypeList.firstWhereOrNull(
                        (e) => e.title.tr == controller.model.userType,
                      ),
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
                      readOnly: true, // Email should not be editable
                      initialValue: controller.model.email,
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
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    CustomButton(
                      title: "update".tr,
                      onTap: () {
                        controller.updateUser();
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
