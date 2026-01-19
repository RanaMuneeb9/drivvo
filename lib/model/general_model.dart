import 'package:get/get.dart';

class GeneralModel {
  final String id;
  final String name;
  final String logoUrl;
  final String fuelType;
  final String location;

  /// Observable
  RxBool isSelected;

  GeneralModel({
    required this.id,
    required this.name,
    required this.logoUrl,
    this.fuelType = "",
    this.location = "",
    bool isSelected = false,
  }) : isSelected = isSelected.obs;

  factory GeneralModel.fromJson(Map<String, dynamic> json) {
    return GeneralModel(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      logoUrl: json["logo_url"] ?? "",
      fuelType: json["fuel_type"] ?? "",
      location: json["location"] ?? "",
      isSelected: json["is_selected"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "logo_url": logoUrl,
      "fuel_type": fuelType,
      "location": location,
      "is_selected": isSelected.value,
    };
  }
}
