class RouteModel {
  late String userId;
  late String vehicleId;
  late String origin;
  late String startDate;
  late String startTime;
  late String endDate;
  late String endTime;
  late double initialOdometer;
  late String destination;
  late double finalOdometer;
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
    startDate = "";
    startTime = "";
    endDate = "";
    endTime = "";
    initialOdometer = 0.0;
    destination = "";
    finalOdometer = 0.0;
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
    startDate = json["start_date"] ?? "";
    startTime = json["start_time"] ?? "";
    endDate = json["end_date"] ?? "";
    endTime = json["end_time"] ?? "";
    initialOdometer = (json["initial_odometer"] ?? 0).toDouble();
    destination = json["destination"] ?? "";
    finalOdometer = (json["final_odometer"] ?? 0).toDouble();
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
