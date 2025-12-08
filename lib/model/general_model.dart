class GeneralModel {
  final String id;
  final String name;

  GeneralModel({required this.id, required this.name});

  factory GeneralModel.fromJson(Map<String, dynamic> json) {
    return GeneralModel(id: json["id"] ?? "", name: json["name"] ?? "");
  }
}
