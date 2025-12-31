import 'package:cloud_firestore/cloud_firestore.dart';

class ReminderModel {
  late String id;
  late String type;
  late String subType;
  late int odometer;
  late String notes;
  late bool oneTime;
  late String period;
  late DateTime startDate;
  late DateTime endDate;

  ReminderModel() {
    id = "";
    type = "";
    subType = "";
    odometer = 0;
    notes = "";
    oneTime = false;
    period = "";
    startDate = DateTime.now();
    endDate = DateTime.now();
  }

  ReminderModel.fromJson(Map<String, dynamic> json) {
    id = json["id"] ?? "";
    type = json["type"] ?? "";
    subType = json["sub_type"] ?? "";
    odometer = json["odometer"] ?? 0;
    notes = json["notes"] ?? "";
    period = json["period"] ?? "";
    oneTime = json["one_time"] ?? false;
    startDate = (json["start_date"] as Timestamp?)?.toDate() ?? DateTime.now();
    endDate = (json["end_date"] as Timestamp?)?.toDate() ?? DateTime.now();
  }
}
