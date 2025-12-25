import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivvo/model/general_model.dart';
import 'package:drivvo/model/vehicle/vehicle_model.dart';
import 'package:drivvo/services/app_service.dart';
import 'package:drivvo/utils/constants.dart';
import 'package:drivvo/utils/database_tables.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateVehiclesController extends GetxController {
  late AppService appService;
  final formStateKey = GlobalKey<FormState>();
  bool get isUrdu => Get.locale?.languageCode == Constants.URDU_LANGUAGE_CODE;

  final manufacturerController = TextEditingController();
  final searchInputController = TextEditingController();

  final manufacturerFilterList = <GeneralModel>[].obs;

  var selectedYear = 2025.obs;
  String manufacturerId = "";

  var selectedTankIndex = 0.obs;
  var selectedDistanceIndex = 0.obs;

  var model = VehicleModel();
  var selectedChipName = "Kilometers".obs;

  @override
  void onInit() {
    appService = Get.find<AppService>();
    super.onInit();

    model = Get.arguments as VehicleModel;

    onSearchManufacturer("");

    searchInputController.addListener(() {
      onSearchManufacturer(searchInputController.text);
    });

    manufacturerController.text = model.manufacturer;

    final manufacturer = Utils.manufacturers.firstWhereOrNull(
      (e) => e.name == model.manufacturer,
    );
    manufacturerId = manufacturer?.id ?? "";

    if (model.tankConfiguration == "two_tank") {
      selectedTankIndex.value = 1;
    }

    if (model.distanceUnit == "Miles") {
      selectedDistanceIndex.value = 1;
    }
  }

  Future<void> saveData() async {
    if (formStateKey.currentState?.validate() == true) {
      formStateKey.currentState?.save();

      Utils.showProgressDialog(Get.context!);
      if (selectedTankIndex.value == 0) {
        model.secFuelCapacity = "";
        model.secFuelType = "";
      }

      final map = model.toJson(model.id);

      FirebaseFirestore.instance
          .collection(DatabaseTables.USER_PROFILE)
          .doc(appService.appUser.value.id)
          .collection(DatabaseTables.VEHICLES)
          .doc(model.id)
          .update(map)
          .then(
            (_) {
              if (appService.currentVehicleId.value == model.id) {
                appService.setCurrentVehicle(model.name);
              }
              Get.back(closeOverlays: true);
              Utils.showSnackBar(
                message: "vehicle_updated_successfully",
                success: true,
              );
            },
            onError: (e) {
              Get.back();
            },
          );
    }
  }

  void onSelectManufacturer(GeneralModel? value) {
    if (value != null) {
      manufacturerId = value.id;
      manufacturerController.text = value.name;
      model.manufacturer = value.name;
    }
  }

  void onSearchManufacturer(String text) {
    manufacturerFilterList.value = Utils.manufacturers
        .where(
          (e) =>
              e.name.toLowerCase().contains(text.toLowerCase()) || text.isEmpty,
        )
        .toList();
  }

  void onSelectVehicleType(String type) {
    model.vehicleType = type;
  }

  void onSelectModelyear(int year) {
    model.modelYear = year;
  }

  void onSelectTank(String? tank) {
    if (tank != null) {
      model.tankConfiguration = tank;
    }
  }

  void onSelectMainFuelType(String? type) {
    if (type != null) {
      model.mainFuelType = type;
    }
  }

  void onSelectSecFuelType(String? type) {
    if (type != null) {
      model.secFuelType = type;
    }
  }

  void toggleDistanceBtn(int index) {
    selectedDistanceIndex.value = index;
    if (index == 0) {
      model.distanceUnit = "Kilometers";
    } else {
      model.distanceUnit = "Miles";
    }
  }

  void toggleTankBtn({required int index, required String tank}) {
    selectedTankIndex.value = index;
    model.tankConfiguration = tank;
  }

  @override
  void onClose() {
    manufacturerController.dispose();
    searchInputController.dispose();
    super.onClose();
  }
}
