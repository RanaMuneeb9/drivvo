import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivvo/model/general_model.dart';
import 'package:drivvo/services/app_service.dart';
import 'package:drivvo/utils/constants.dart';
import 'package:drivvo/utils/database_tables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MultipleServiceController extends GetxController {
  late AppService appService;
  var isLoading = false.obs;

  var abc = "".obs;

  var sericeFilterList = <GeneralModel>[].obs;
  List<GeneralModel> servicelList = [];
  final searchInputController = TextEditingController();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  bool get isUrdu => Get.locale?.languageCode == Constants.URDU_LANGUAGE_CODE;

  @override
  void onInit() {
    appService = Get.find<AppService>();
    super.onInit();

    searchInputController.addListener(() {
      onSearch(searchInputController.text);
    });

    getServices();
  }

  Future<void> getServices() async {
    isLoading.value = true;
    sericeFilterList.clear();
    servicelList.clear();

    try {
      final snapshot = await db
          .collection(DatabaseTables.USER_PROFILE)
          .doc(appService.appUser.value.id)
          .collection(DatabaseTables.SERVICE_TYPES)
          .get();

      if (snapshot.docs.isNotEmpty) {
        servicelList = snapshot.docs.map((doc) {
          return GeneralModel.fromJson(doc.data());
        }).toList();

        onSearch("");
      }
    } catch (e) {
      debugPrint("Error fetching in service: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void onSearch(String text) {
    final filteredList = servicelList
        .where((e) => e.name.toLowerCase().contains(text.toLowerCase()))
        .toList();

    filteredList.sort(
      (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
    );

    sericeFilterList.value = filteredList;
  }

  @override
  void onClose() {
    searchInputController.dispose();
    super.onClose();
  }
}
