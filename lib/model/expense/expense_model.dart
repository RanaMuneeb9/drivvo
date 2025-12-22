import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivvo/model/expense/expense_type_model.dart';

class ExpenseModel {
  late String userId;
  late String vehicleId;
  late String time;
  late DateTime date;
  late String odometer;
  late String totalAmount;
  late String place;
  late String driverName;
  late String paymentMethod;
  late String reason;
  late String filePath;
  late String notes;
  late List<ExpenseTypeModel> expenseTypes;

  ExpenseModel() {
    userId = "";
    vehicleId = "";
    time = "";
    date = DateTime.now();
    odometer = "";
    totalAmount = "";
    place = "";
    driverName = "";
    paymentMethod = "";
    reason = "";
    filePath = "";
    notes = "";
    expenseTypes = [];
  }

  ExpenseModel.fromJson(Map<String, dynamic> json) {
    userId = json["user_id"] ?? "";
    vehicleId = json["vehicle_id"] ?? "";
    time = json["time"] ?? "";
    date = (json["date"] as Timestamp?)?.toDate() ?? DateTime.now();
    odometer = json["odometer"] ?? "";
    totalAmount = json["total_amount"] ?? "";
    place = json["place"] ?? "";
    driverName = json["driver_name"] ?? "";
    paymentMethod = json["payment_method"] ?? "";
    reason = json["reason"] ?? "";
    filePath = json["file_path"] ?? "";
    notes = json["notes"] ?? "";
    expenseTypes =
        (json["expense_types"] as List<dynamic>?)
            ?.map((e) => ExpenseTypeModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
  }
}
