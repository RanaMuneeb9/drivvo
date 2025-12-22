import 'package:cloud_firestore/cloud_firestore.dart';

class RefuelingModel {
  late String userId;
  late String vehicleId;
  late String time;
  late DateTime date;
  late String odometer;
  late String price;
  late String liter;
  late String totalCost;
  late String fuelType;
  late String fuelStation;
  late bool fullTank;
  late bool missedPrevious;
  late String paymentMethod;
  late String notes;
  late String driverName;

  RefuelingModel() {
    userId = "";
    vehicleId = "";
    time = "";
    date = DateTime.now();
    odometer = "";
    price = "0";
    liter = "0";
    totalCost = "0";
    fuelType = "";
    fuelStation = "";
    fullTank = true;
    missedPrevious = false;
    paymentMethod = "";
    notes = "";
    driverName = "";
  }

  RefuelingModel.fromJson(Map<String, dynamic> json) {
    userId = json["user_id"] ?? "";
    vehicleId = json["vehicle_id"] ?? "";
    time = json["time"] ?? "";
    date = (json["date"] as Timestamp?)?.toDate() ?? DateTime.now();
    odometer = json["odometer"] ?? "";
    price = json["price"] ?? "";
    liter = json["liter"] ?? "";
    totalCost = json["total_cost"] ?? "";
    fuelType = json["fuel_type"] ?? "";
    fuelStation = json["fuel_station"] ?? "";
    fullTank = json["full_tank"] ?? true;
    missedPrevious = json["missed_previous"] ?? false;
    paymentMethod = json["payment_method"] ?? "";
    notes = json["notes"] ?? "";
    driverName = json["driver_name"] ?? "";
  }
}
