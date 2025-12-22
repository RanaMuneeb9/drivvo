import 'package:cloud_firestore/cloud_firestore.dart';

class IncomeModel {
  late String userId;
  late String vehicleId;
  late String time;
  late DateTime date;
  late String odometer;
  late String incomeType;
  late String value;
  late String driverName;
  late String filePath;
  late String notes;

  IncomeModel() {
    userId = "";
    vehicleId = "";
    time = "";
    date = DateTime.now();
    odometer = "";
    incomeType = "";
    value = "";
    driverName = "";
    filePath = "";
    notes = "";
  }

  IncomeModel.fromJson(Map<String, dynamic> json) {
    userId = json["user_id"] ?? "";
    vehicleId = json["vehicle_id"] ?? "";
    time = json["time"] ?? "";
    date = (json["date"] as Timestamp?)?.toDate() ?? DateTime.now();
    odometer = json["odometer"] ?? "";
    incomeType = json["income_type"] ?? "";
    value = json["value"] ?? "";
    driverName = json["driver_name"] ?? "";
    filePath = json["file_path"] ?? "";
    notes = json["notes"] ?? "";
  }
}
