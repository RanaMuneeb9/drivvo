class IncomeModel {
  late String userId;
  late String vehicleId;
  late String time;
  late String date;
  late double odometer;
  late String incomeType;
  late double value;
  late String driverName;
  late String filePath;
  late String notes;

  IncomeModel() {
    userId = "";
    vehicleId = "";
    time = "";
    date = "";
    odometer = 0.0;
    incomeType = "";
    value = 0.0;
    driverName = "";
    filePath = "";
    notes = "";
  }

  IncomeModel.fromJson(Map<String, dynamic> json) {
    userId = json["user_id"] ?? "";
    vehicleId = json["vehicle_id"] ?? "";
    time = json["time"] ?? "";
    date = json["date"] ?? "";
    odometer = (json["odometer"] ?? 0).toDouble();
    incomeType = json["income_type"] ?? "";
    value = (json["value"] ?? 0).toDouble();
    driverName = json["driver_name"] ?? "";
    filePath = json["file_path"] ?? "";
    notes = json["notes"] ?? "";
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "vehicle_id": vehicleId,
      "time": time,
      "date": date,
      "odometer": odometer,
      "income_type": incomeType,
      "value": value,
      "driver_name": driverName,
      "file_path": filePath,
      "notes": notes,
    };
  }

}
