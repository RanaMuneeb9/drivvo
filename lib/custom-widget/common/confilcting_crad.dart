import 'package:drivvo/model/last_record_model.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConflictingCard extends StatelessWidget {
  final bool isUrdu;
  final LastRecordModel lastRecordModel;
  final Function onTap;

  const ConflictingCard({
    super.key,
    required this.isUrdu,
    required this.lastRecordModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "The odometer and date data are conflicting with a previous ${lastRecordModel.type} (${lastRecordModel.odometer} km - ${Utils.formatDate(date: lastRecordModel.date)})",
              style: Utils.getTextStyle(
                baseSize: 15,
                isBold: false,
                color: Colors.white,
                isUrdu: isUrdu,
              ),
            ),
          ),
          TextButton(
            onPressed: () => onTap(),
            child: Text(
              "ok".tr,
              style: Utils.getTextStyle(
                baseSize: 15,
                isBold: true,
                color: Colors.white,
                isUrdu: isUrdu,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
