import 'package:get/get.dart';

class ExpenseTypeModel {
  final String id;
  final String name;
  final RxString value;
  final RxBool isChecked;

  ExpenseTypeModel({
    required this.id,
    required this.name,
    String value = "",
    bool isChecked = false,
  }) : value = value.obs,
       isChecked = isChecked.obs;

  /// Empty model (optional)
  factory ExpenseTypeModel.empty() {
    return ExpenseTypeModel(id: "", name: "");
  }

  /// From Firestore
  factory ExpenseTypeModel.fromJson(Map<String, dynamic> json) {
    return ExpenseTypeModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      value: json["value"] ?? "",
      isChecked: json["isChecked"] ?? false,
    );
  }

  /// To Firestore
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "value": value.value,
      "isChecked": isChecked.value,
    };
  }
}
