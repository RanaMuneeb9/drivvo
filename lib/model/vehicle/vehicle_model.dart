class VehicleModel {
  late String id;
  late String vehicleType;
  late String name;
  late String manufacturer;
  late int modelYear;
  late String licensePlate;
  late String tankConfiguration;
  late String mainFuelType;
  late String mainFuelCapacity;
  late String secFuelType;
  late String secFuelCapacity;
  late String distanceUnit;
  late String chassisNumber;
  late String identificationNumber;
  late String notes;

  VehicleModel() {
    id = "";
    vehicleType = "";
    name = "";
    manufacturer = "";
    modelYear = 0;
    licensePlate = "";
    tankConfiguration = "";
    mainFuelType = "";
    mainFuelCapacity = "";
    secFuelType = "";
    secFuelCapacity = "";
    distanceUnit = "";
    chassisNumber = "";
    identificationNumber = "";
    notes = "";
  }

  VehicleModel.fromJson(Map<String, dynamic> json) {
    id = json["id"] ?? "";
    vehicleType = json["vehicle_type"] ?? "";
    name = json["name"] ?? "";
    manufacturer = json["manufacturer"] ?? "";
    modelYear = json["model_year"] ?? 0;
    licensePlate = json["license_plate"] ?? "";
    tankConfiguration = json["tank_configuration"] ?? "";
    mainFuelType = json["main_fuel_type"] ?? "";
    mainFuelCapacity = json["main_fuel_capacity"] ?? "";
    secFuelType = json["sec_fuel_type"] ?? "";
    secFuelCapacity = json["sec_fuel_capacity"] ?? "";
    distanceUnit = json["distance_unit"] ?? "";
    chassisNumber = json["chassis_number"] ?? "";
    identificationNumber = json["identification_number"] ?? "";
    notes = json["notes"] ?? "";
  }

  Map<String, dynamic> toJson(String id) {
    return {
      "id": id,
      "vehicle_type": vehicleType,
      "name": name,
      "manufacturer": manufacturer,
      "model_year": modelYear,
      "license_plate": licensePlate,
      "tank_configuration": tankConfiguration,
      "main_fuel_type": mainFuelType,
      "main_fuel_capacity": mainFuelCapacity,
      "sec_fuel_type": secFuelType,
      "sec_fuel_capacity": secFuelCapacity,
      "distance_unit": distanceUnit,
      "chassis_number": chassisNumber,
      "identification_number": identificationNumber,
      "notes": notes,
    };
  }
}
