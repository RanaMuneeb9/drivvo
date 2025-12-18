import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  late String userId;
  late String vehicleId;
  late String time;
  late DateTime date;
  late String odometer;
  late String price;
  late String liter;
  late String totalAmount;
  late String fuelType;
  late String fuelStation;
  late bool fullTank;
  late bool missedPrevious;
  late String paymentMethod;
  late String notes;
  late String driverName;
  // late DateTime createdAt;

  ServiceModel() {
    userId = "";
    vehicleId = "";
    time = "";
    date = DateTime.now();
    odometer = "";
    price = "";
    liter = "";
    totalAmount = "";
    fuelType = "";
    fuelStation = "";
    fullTank = true;
    missedPrevious = false;
    paymentMethod = "";
    notes = "";
    driverName = "";
    // createdAt = DateTime.now();
  }

  ServiceModel.fromJson(Map<String, dynamic> json) {
    userId = json["user_id"] ?? "";
    vehicleId = json["vehicle_id"] ?? "";
    time = json["time"] ?? "";
    date = (json["date"] as Timestamp?)?.toDate() ?? DateTime.now();
    odometer = json["odometer"] ?? "";
    price = json["price"] ?? "";
    liter = json["liter"] ?? "";
    totalAmount = json["total_amount"] ?? "";
    fuelType = json["fuel_type"] ?? "";
    fuelStation = json["fuel_station"] ?? "";
    fullTank = json["full_tank"] ?? true;
    missedPrevious = json["missed_previous"] ?? false;
    paymentMethod = json["payment_method"] ?? "";
    notes = json["notes"] ?? "";
    driverName = json["driver_name"] ?? "";
    // createdAt = (json["created_at"] as Timestamp?)?.toDate() ?? DateTime.now();
  }

  Map<String, dynamic> toJson() {
    return {
      "id": userId,
      "vehicle_id": vehicleId,
      "time": time,
      "date": Timestamp.fromDate(date),
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
    };
  }
}
