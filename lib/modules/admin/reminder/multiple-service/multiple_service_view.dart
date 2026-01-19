import 'package:drivvo/custom-widget/common/error_refresh_view.dart';
import 'package:drivvo/custom-widget/common/refresh_indicator_view.dart';
import 'package:drivvo/custom-widget/text-input-field/search_text_input_field.dart';
import 'package:drivvo/modules/admin/reminder/multiple-service/multiple_service_controller.dart';
import 'package:drivvo/utils/constants.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultipleServiceView extends GetView<MultipleServiceController> {
  const MultipleServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Get.back(result: controller.abc.value);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Get.back(result: controller.abc.value),
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Text(
            Constants.SERVICE_TYPES.tr,
            style: Utils.getTextStyle(
              baseSize: 18,
              isBold: true,
              color: Colors.white,
              isUrdu: controller.isUrdu,
            ),
          ),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () {
                Get.back(result: controller.abc.value);
              },
              icon: Icon(Icons.check, color: Colors.white),
            ),
          ],
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
                  hintKey: "search_by_name",
                  isUrdu: controller.isUrdu,
                  fillColors: Colors.white,
                ),
              ),

              SizedBox(height: 20),
              Obx(
                () => Expanded(
                  child: controller.isLoading.value
                      ? RefreshIndicatorView()
                      : controller.sericeFilterList.isEmpty
                      ? ErrorRefreshView(
                          onRefresh: () => controller.getServices(),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.only(bottom: 66),
                          itemCount: controller.sericeFilterList.length,
                          itemBuilder: (context, index) {
                            final model = controller.sericeFilterList[index];
                            return GestureDetector(
                              onTap: () {
                                model.isSelected.value =
                                    !model.isSelected.value;

                                controller.abc.value += "${model.name},";
                                controller.sericeFilterList.refresh();
                              },
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
                                    color: model.isSelected.value
                                        ? Utils.appColor
                                        : Colors.grey.shade300,
                                    width: model.isSelected.value ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model.name,
                                            style: Utils.getTextStyle(
                                              baseSize: 16,
                                              isBold: false,
                                              color: Colors.black,
                                              isUrdu: controller.isUrdu,
                                            ),
                                          ),
                                          if (model.fuelType.isNotEmpty)
                                            Text(
                                              "${"type".tr}: ${model.fuelType}",
                                              style: Utils.getTextStyle(
                                                baseSize: 14,
                                                isBold: false,
                                                color: Colors.grey.shade500,
                                                isUrdu: controller.isUrdu,
                                              ),
                                            ),
                                          if (model.location.isNotEmpty)
                                            Text(
                                              "${"location".tr}: ${model.location}",
                                              style: Utils.getTextStyle(
                                                baseSize: 14,
                                                isBold: false,
                                                color: Colors.grey.shade700,
                                                isUrdu: controller.isUrdu,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => Utils.showAlertDialog(
                                        confirmMsg: "are_you_sure_delete".tr,
                                        onTapYes: () {},
                                        isUrdu: controller.isUrdu,
                                      ),
                                      child: Icon(
                                        Icons.delete_forever_outlined,
                                        size: 24,
                                        color: Colors.red,
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
      ),
    );
  }
}
