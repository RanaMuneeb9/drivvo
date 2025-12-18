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
  // late DateTime createdAt;

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
    // createdAt = DateTime.now();
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
    // createdAt = (json["created_at"] as Timestamp?)?.toDate() ?? DateTime.now();
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "vehicle_id": vehicleId,
      "time": time,
      "date": date,
      "odometer": odometer,
      "total_amount": totalAmount,
      "place": place,
      "driver_name": driverName,
      "payment_method": paymentMethod,
      "reason": reason,
      "file_path": filePath,
      "notes": notes,
      "expense_types": expenseTypes.map((e) => e.toJson()).toList(),
    };
  }
}
