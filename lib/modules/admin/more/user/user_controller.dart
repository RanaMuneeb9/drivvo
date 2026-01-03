import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivvo/model/app_user.dart';
import 'package:drivvo/services/app_service.dart';
import 'package:drivvo/utils/constants.dart';
import 'package:drivvo/utils/database_tables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  late AppService appService;

  List<AppUser> userList = [];
  var userFilterList = <AppUser>[].obs;
  bool get isUrdu => Get.locale?.languageCode == Constants.URDU_LANGUAGE_CODE;

  var isLoading = false.obs;
  final searchInputController = TextEditingController();
  final db = FirebaseFirestore.instance;

  var selectedUserName = "".obs;

  @override
  void onInit() {
    appService = Get.find<AppService>();
    super.onInit();

    selectedUserName.value = Get.arguments;

    searchInputController.addListener(() {
      onSearchUser(searchInputController.text);
    });

    getUserList();
  }

  Future<void> getUserList() async {
    isLoading.value = true;
    userList.clear();
    userFilterList.clear();
    try {
      final snapshot = await db
          .collection(DatabaseTables.USER_PROFILE)
          .where("admin_id", isEqualTo: appService.appUser.value.id)
          .get();

      if (snapshot.docs.isNotEmpty) {
        userList.addAll(
          snapshot.docs.map((doc) => AppUser.fromJson(doc.data())).toList(),
        );
        onSearchUser("");
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  void onSearchUser(String text) {
    userFilterList.value = userList
        .where(
          (e) =>
              e.firstName.toLowerCase().contains(text.toLowerCase()) ||
              e.lastName.toLowerCase().contains(text.toLowerCase()) ||
              e.email.toLowerCase().contains(text.toLowerCase()) ||
              text.isEmpty,
        )
        .toList();
  }

  @override
  void onClose() {
    searchInputController.dispose();
    super.onClose();
  }
}
