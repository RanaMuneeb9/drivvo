import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivvo/model/expense/expense_type_model.dart';
import 'package:drivvo/modules/home/expense/create_expense_controller.dart';
import 'package:drivvo/services/app_service.dart';
import 'package:drivvo/utils/constants.dart';
import 'package:drivvo/utils/database_tables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseTypeController extends GetxController {
  late AppService appService;
  var isLoading = false.obs;

  var isChecked = false.obs;

  late List<ExpenseTypeModel> selectedList;

  var filterList = <ExpenseTypeModel>[].obs;
  List<ExpenseTypeModel> generalList = [];
  final searchInputController = TextEditingController();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  bool get isUrdu => Get.locale?.languageCode == Constants.URDU_LANGUAGE_CODE;

  @override
  void onInit() {
    appService = Get.find<AppService>();

    selectedList = (Get.arguments ?? []) as List<ExpenseTypeModel>;
    super.onInit();

    searchInputController.addListener(() {
      onSearch(searchInputController.text);
    });

    getExpeseTypes();
  }

  Future<void> getExpeseTypes() async {
    isLoading.value = true;
    generalList.clear();
    filterList.clear();

    try {
      final snapshot = await db
          .collection(DatabaseTables.USER_PROFILE)
          .doc(appService.appUser.value.id)
          .collection(DatabaseTables.EXPENSE_TYPES)
          .get();

      if (snapshot.docs.isNotEmpty) {
        generalList = snapshot.docs.map((doc) {
          return ExpenseTypeModel.fromJson(doc.data());
        }).toList();

        onSearch("");

        for (final item in filterList) {
          final matchedItem = selectedList.firstWhereOrNull(
            (e) => e.id == item.id,
          );

          if (matchedItem != null) {
            item.value.value = matchedItem.value.value;
            item.isChecked.value = true;
          }

          item.value.refresh();
        }
      }
    } catch (e) {
      debugPrint("Error fetching");
    } finally {
      isLoading.value = false;
    }
  }

  void onSearch(String text) {
    filterList.value = generalList
        .where((e) => e.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
  }

  void onTapBack() {
    final con = Get.find<CreateExpenseController>();
    con.expenseTypesList.clear();

    final list = filterList.where((e) => e.isChecked.value == true).toList();
    con.expenseTypesList.value = list;
    con.calculateTotal();
    con.expenseTypesList.refresh();
    Get.back();
  }

  @override
  void onClose() {
    searchInputController.dispose();
    super.onClose();
  }
}
