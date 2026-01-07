import 'package:drivvo/custom-widget/common/custom_app_bar.dart';
import 'package:drivvo/custom-widget/common/error_refresh_view.dart';
import 'package:drivvo/custom-widget/common/profile_network_image.dart';
import 'package:drivvo/custom-widget/common/refresh_indicator_view.dart';
import 'package:drivvo/custom-widget/text-input-field/search_text_input_field.dart';
import 'package:drivvo/modules/admin/more/vehicles/vehicles_controller.dart';
import 'package:drivvo/routes/app_routes.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehiclesView extends GetView<VehiclesController> {
  const VehiclesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            Get.toNamed(AppRoutes.CREATE_VEHICLES_VIEW, arguments: false)?.then(
              (e) {
                controller.getVehicleList();
              },
            ),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF00796B),
        shape: const StadiumBorder(),
        icon: const Icon(Icons.add),
        label: Text(
          "add_vehicle".tr,
          style: Utils.getTextStyle(
            baseSize: 14,
            isBold: true,
            color: Colors.white,
            isUrdu: controller.isUrdu,
          ),
        ),
      ),
      appBar: CustomAppBar(
        name: "Vehicles",
        isUrdu: controller.isUrdu,
        bgColor: Utils.appColor,
        textColor: Colors.white,
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
                    : controller.filterVehiclesList.isEmpty
                    ? ErrorRefreshView(
                        onRefresh: () => controller.getVehicleList(),
                      )
                    : ListView.builder(
                        itemCount: controller.filterVehiclesList.length,
                        itemBuilder: (context, index) {
                          final model = controller.filterVehiclesList[index];
                          return GestureDetector(
                            onTap: () {
                              controller.isFromHome.value
                                  ? controller.getBackToHome(vehicle: model)
                                  : controller.isFromUser.value
                                  ? Get.back(result: model)
                                  : Get.toNamed(
                                      AppRoutes.UPDATE_VEHICLE_VIEW,
                                      arguments: model,
                                    )?.then((_) {
                                      controller.getVehicleList();
                                    });
                            },
                            child: Container(
                              width: double.maxFinite,
                              margin: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                bottom: 10,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: controller.isFromHome.value
                                    ? controller
                                                  .appService
                                                  .currentVehicleId
                                                  .value ==
                                              model.id
                                          ? Border.all(
                                              color: Utils.appColor,
                                              width: 1,
                                            )
                                          : Border.all(
                                              color: Colors.grey.shade300,
                                              width: 1,
                                            )
                                    : controller.isFromUser.value
                                    ? Border.all(
                                        color: Colors.grey.shade300,
                                        width: 1,
                                      )
                                    : Border.all(
                                        color: Colors.grey.shade300,
                                        width: 1,
                                      ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  ProfileNetworkImage(
                                    imageUrl: model.logoUrl,
                                    width: 50,
                                    height: 30,
                                    borderRadius: 0,
                                    placeholder:
                                        "assets/images/car_placeholder.png",
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          model.name,
                                          style: Utils.getTextStyle(
                                            baseSize: 15,
                                            isBold: true,
                                            color: Colors.black,
                                            isUrdu: controller.isUrdu,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                model.manufacturer,
                                                style: Utils.getTextStyle(
                                                  baseSize: 14,
                                                  isBold: false,
                                                  color: Colors.black,
                                                  isUrdu: controller.isUrdu,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              " ${model.modelYear}",
                                              style: Utils.getTextStyle(
                                                baseSize: 14,
                                                isBold: true,
                                                color: Utils.appColor,
                                                isUrdu: controller.isUrdu,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
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
