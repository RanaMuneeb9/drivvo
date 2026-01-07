import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivvo/model/reminder/reminder_model.dart';
import 'package:drivvo/services/app_service.dart';
import 'package:drivvo/services/notification_service.dart';
import 'package:drivvo/utils/constants.dart';
import 'package:drivvo/utils/database_tables.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReminderController extends GetxController {
  late AppService appService;
  var isLoading = false.obs;
  var reminderList = <ReminderModel>[].obs;
  var lastOdometer = 0.obs;
  bool get isUrdu => Get.locale?.languageCode == Constants.URDU_LANGUAGE_CODE;

  StreamSubscription? _subscription;
  bool _isFirstTime = true;
  bool _isSchedulingReminders = false; // Guard to prevent concurrent scheduling

  @override
  void onInit() {
    appService = Get.find<AppService>();
    super.onInit();
    getReminders();

    lastOdometer.value = appService.vehicleModel.value.lastOdometer;
  }

  @override
  void onClose() {
    _subscription?.cancel();
    _subscription = null;
    _isSchedulingReminders = false;
    super.onClose();
  }

  Future<void> getReminders() async {
    // Cancel existing subscription before creating new one
    await _subscription?.cancel();
    _subscription = null;

    isLoading.value = true;

    try {
      _subscription = FirebaseFirestore.instance
          .collection(DatabaseTables.USER_PROFILE)
          .doc(appService.appUser.value.id)
          .collection(DatabaseTables.REMINDER)
          .snapshots()
          .listen(
            (docSnapshot) async {
              try {
                if (docSnapshot.docs.isNotEmpty) {
                  reminderList.value = docSnapshot.docs.map((doc) {
                    return ReminderModel.fromJson(doc.data());
                  }).toList();

                  // Atomic check-and-set to prevent race condition
                  // Use local variable to capture the flag state atomically
                  final shouldSchedule =
                      _isFirstTime && !_isSchedulingReminders;

                  if (shouldSchedule && reminderList.isNotEmpty) {
                    // Set flag immediately to prevent concurrent execution
                    _isSchedulingReminders = true;
                    _isFirstTime = false;

                    try {
                      await NotificationService().scheduleReminders(
                        reminders: reminderList,
                      );
                    } catch (e) {
                      debugPrint('Error scheduling reminders: $e');
                      // Reset flag on error so it can be retried
                      _isFirstTime = true;
                    } finally {
                      _isSchedulingReminders = false;
                    }
                  }
                }
                isLoading.value = false;
              } catch (e) {
                debugPrint('Error processing reminder snapshot: $e');
                isLoading.value = false;
              }
            },
            onError: (e) {
              debugPrint('Reminder stream error: $e');
              _subscription?.cancel();
              _subscription = null;
              isLoading.value = false;
            },
            cancelOnError: false,
          );
    } catch (e) {
      isLoading.value = false;
      Utils.showSnackBar(message: "something_went_wrong".tr, success: false);
      // Ensure subscription is canceled on exception
      await _subscription?.cancel();
      _subscription = null;
    }
  }

  int getDistance(ReminderModel model) {
    return model.odometer - lastOdometer.value;
  }

  int getDays(DateTime targetDate) {
    DateTime today = DateTime.now();

    // Normalize both to remove time difference
    DateTime normalizedToday = DateTime(today.year, today.month, today.day);
    DateTime normalizedTarget = DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
    );

    if (normalizedTarget.isAfter(normalizedToday)) {
      int daysCount = normalizedTarget.difference(normalizedToday).inDays;
      return daysCount;
    } else {
      return 0;
    }
  }
}
