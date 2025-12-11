import 'package:drivvo/model/expense/expense_type_model.dart';

class ExpenseModel {
  late String userId;
  late String vehicleId;
  late String time;
  late String date;
  late double odometer;
  late double totalAmount;
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
    date = "";
    odometer = 0.0;
    totalAmount = 0.0;
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
    date = json["date"] ?? "";
    odometer = (json["odometer"] ?? 0).toDouble();
    totalAmount = (json["total_amount"] ?? 0).toDouble();
    place = json["place"] ?? "";
    driverName = json["driver_name"] ?? "";
    paymentMethod = json["payment_method"] ?? "";
    reason = json["reason"] ?? "";
    filePath = json["file_path"] ?? "";
    notes = json["notes"] ?? "";
    expenseTypes = (json["expense_types"] as List<dynamic>?)
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

  /// Creates a copy of this model with updated values
  ExpenseModel copyWith({
    String? userId,
    String? vehicleId,
    String? time,
    String? date,
    double? odometer,
    double? totalAmount,
    String? place,
    String? driverName,
    String? paymentMethod,
    String? reason,
    String? filePath,
    String? notes,
    List<ExpenseTypeModel>? expenseTypes,
  }) {
    return ExpenseModel()
      ..userId = userId ?? this.userId
      ..vehicleId = vehicleId ?? this.vehicleId
      ..time = time ?? this.time
      ..date = date ?? this.date
      ..odometer = odometer ?? this.odometer
      ..totalAmount = totalAmount ?? this.totalAmount
      ..place = place ?? this.place
      ..driverName = driverName ?? this.driverName
      ..paymentMethod = paymentMethod ?? this.paymentMethod
      ..reason = reason ?? this.reason
      ..filePath = filePath ?? this.filePath
      ..notes = notes ?? this.notes
      ..expenseTypes = expenseTypes ?? List.from(this.expenseTypes);
  }
}
