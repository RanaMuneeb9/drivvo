import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivvo/model/expense/expense_type_model.dart';

class ServiceModel {
  late String userId;
  late String vehicleId;
  late String time;
  late DateTime date;
  late int odometer;
  late int price;
  late int liter;
  late int totalAmount;
  late String fuelType;
  late String fuelStation;
  late bool fullTank;
  late bool missedPrevious;
  late String paymentMethod;
  late String notes;
  late String driverName;
  late List<ExpenseTypeModel> serviceTypes;
  Map<String, dynamic> rawMap = {};

  ServiceModel() {
    userId = "";
    vehicleId = "";
    time = "";
    date = DateTime.now();
    odometer = 0;
    price = 0;
    liter = 0;
    totalAmount = 0;
    fuelType = "";
    fuelStation = "";
    fullTank = true;
    missedPrevious = false;
    paymentMethod = "";
    notes = "";
    driverName = "";
    serviceTypes = [];
  }

  ServiceModel.fromJson(Map<String, dynamic> json) {
    rawMap = json;
    userId = json["user_id"] ?? "";
    vehicleId = json["vehicle_id"] ?? "";
    time = json["time"] ?? "";
    date = (json["date"] as Timestamp?)?.toDate() ?? DateTime.now();
    odometer = json["odometer"] ?? 0;
    price = json["price"] ?? 0;
    liter = json["liter"] ?? 0;
    totalAmount = json["total_amount"] ?? 0;
    fuelType = json["fuel_type"] ?? "";
    fuelStation = json["fuel_station"] ?? "";
    fullTank = json["full_tank"] ?? true;
    missedPrevious = json["missed_previous"] ?? false;
    paymentMethod = json["payment_method"] ?? "";
    notes = json["notes"] ?? "";
    driverName = json["driver_name"] ?? "";
    serviceTypes =
        (json["expense_types"] as List<dynamic>?)
            ?.map((e) => ExpenseTypeModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "vehicle_id": vehicleId,
      "time": time,
      "date": date,
      "odometer": odometer,
      "price": price,
      "liter": liter,
      "total_amount": totalAmount,
      "fuel_type": fuelType,
      "fuel_station": fuelStation,
      "full_tank": fullTank,
      "missed_previous": missedPrevious,
      "payment_method": paymentMethod,
      "notes": notes,
      "driver_name": driverName,
      "expense_types": serviceTypes.map((e) => e.toJson()).toList(),
    };
  }
}
