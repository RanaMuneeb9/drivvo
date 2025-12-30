import 'package:cloud_firestore/cloud_firestore.dart';

class LastRecordModel {
  late String type;
  late DateTime date;
  late int odometer;

  LastRecordModel() {
    type = "";
    date = DateTime.now();
    odometer = 0;
  }

  LastRecordModel.fromJson(Map<String, dynamic> json) {
    type = json["type"] ?? "";
    date = (json["date"] as Timestamp?)?.toDate() ?? DateTime.now();
    odometer = json["odometer"] ?? 0;
  }
}
