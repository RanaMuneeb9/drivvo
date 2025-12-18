import 'package:cloud_firestore/cloud_firestore.dart';

class RouteModel {
  late String userId;
  late String vehicleId;
  late String origin;
  late DateTime startDate;
  late String startTime;
  late DateTime endDate;
  late String endTime;
  late String initialOdometer;
  late String destination;
  late String finalOdometer;
  late double valuePerKm;
  late double total;
  late String driverName;
  late String reason;
  late String filePath;
  late String notes;

  RouteModel() {
    userId = "";
    vehicleId = "";
    origin = "";
    startDate = DateTime.now();
    startTime = "";
    endDate = DateTime.now();
    endTime = "";
    initialOdometer = "";
    destination = "";
    finalOdometer = "";
    valuePerKm = 0.0;
    total = 0.0;
    driverName = "";
    reason = "";
    filePath = "";
    notes = "";
  }

  RouteModel.fromJson(Map<String, dynamic> json) {
    userId = json["user_id"] ?? "";
    vehicleId = json["vehicle_id"] ?? "";
    origin = json["origin"] ?? "";
    startDate = (json["start_date"] as Timestamp?)?.toDate() ?? DateTime.now();
    startTime = json["start_time"] ?? "";
    endDate = (json["end_date"] as Timestamp?)?.toDate() ?? DateTime.now();
    endTime = json["end_time"] ?? "";
    initialOdometer = json["initial_odometer"] ?? "";
    destination = json["destination"] ?? "";
    finalOdometer = json["final_odometer"] ?? "";
    valuePerKm = (json["value_per_km"] ?? 0).toDouble();
    total = (json["total"] ?? 0).toDouble();
    driverName = json["driver_name"] ?? "";
    reason = json["reason"] ?? "";
    filePath = json["file_path"] ?? "";
    notes = json["notes"] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "vehicle_id": vehicleId,
      "origin": origin,
      "start_date": startDate,
      "start_time": startTime,
      "end_date": endDate,
      "end_time": endTime,
      "initial_odometer": initialOdometer,
      "destination": destination,
      "final_odometer": finalOdometer,
      "value_per_km": valuePerKm,
      "total": total,
      "driver_name": driverName,
      "reason": reason,
      "file_path": filePath,
      "notes": notes,
    };
  }
}
