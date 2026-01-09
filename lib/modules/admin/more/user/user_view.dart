import 'package:drivvo/custom-widget/common/error_refresh_view.dart';
import 'package:drivvo/custom-widget/common/refresh_indicator_view.dart';
import 'package:drivvo/custom-widget/text-input-field/search_text_input_field.dart';
import 'package:drivvo/modules/admin/more/user/user_controller.dart';
import 'package:drivvo/routes/app_routes.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserView extends GetView<UserController> {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (controller.appService.appUser.value.isSubscribed) {
            Get.toNamed(AppRoutes.CREATE_USER_VIEW);
          } else {
            Get.toNamed(AppRoutes.PLAN_VIEW);
          }
        },
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF00796B),
        shape: const StadiumBorder(),
        icon: const Icon(Icons.add),
        label: Text(
          "add_user".tr,
          style: Utils.getTextStyle(
            baseSize: 14,
            isBold: true,
            color: Colors.white,
            isUrdu: controller.isUrdu,
          ),
        ),
      ),
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
          'users'.tr,
          style: Utils.getTextStyle(
            baseSize: 18,
            isBold: true,
            color: Colors.white,
            isUrdu: controller.isUrdu,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Utils.appColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: SearchTextInputField(
                controller: controller.searchInputController,
                hintKey: "search_by_name_email",
                isUrdu: controller.isUrdu,
                fillColors: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Obx(
              () => Expanded(
                child: controller.isLoading.value
                    ? RefreshIndicatorView()
                    : controller.userFilterList.isEmpty
                    ? ErrorRefreshView(
                        onRefresh: () => controller.getUserList(),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.only(bottom: 66),
                        itemCount: controller.userFilterList.length,
                        itemBuilder: (context, index) {
                          final model = controller.userFilterList[index];
                          return GestureDetector(
                            onTap: () =>
                                controller.selectedUserName.value.isNotEmpty
                                ? Get.back(result: model)
                                : Get.toNamed(
                                    AppRoutes.UPDATE_USER_VIEW,
                                    arguments: model,
                                  )?.then((e) => controller.getUserList()),
                            child: Container(
                              width: double.maxFinite,
                              margin: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                bottom: 10,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                //color: const Color(0xFFF7F7F7),
                                color: Colors.white,
                                border: Border.all(
                                  color:
                                      controller.selectedUserName.value ==
                                          "${model.firstName} ${model.lastName}"
                                      ? Utils.appColor
                                      : Colors.grey.shade300,
                                  width:
                                      controller.selectedUserName.value ==
                                          "${model.firstName} ${model.lastName}"
                                      ? 2
                                      : 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${model.firstName} ${model.lastName}",
                                        style: Utils.getTextStyle(
                                          baseSize: 16,
                                          isBold: false,
                                          color: Colors.black,
                                          isUrdu: controller.isUrdu,
                                        ),
                                      ),
                                      Text(
                                        model.email,
                                        style: Utils.getTextStyle(
                                          baseSize: 14,
                                          isBold: false,
                                          color: Colors.black54,
                                          isUrdu: controller.isUrdu,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    model.userType.toUpperCase(),
                                    style: Utils.getTextStyle(
                                      baseSize: 12,
                                      isBold: true,
                                      color: Utils.appColor,
                                      isUrdu: controller.isUrdu,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
