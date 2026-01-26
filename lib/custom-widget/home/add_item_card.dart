import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class AddItemCard extends StatelessWidget {
  final bool isUrdu;
  final String title;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const AddItemCard({
    super.key,
    required this.isUrdu,
    required this.title,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 14),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          child: InkWell(
            onTap: () => onTap(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Icon(icon, color: Colors.white),
                ),
                SizedBox(width: 14),
                Text(
                  title.tr,
                  style: Utils.getTextStyle(
                    baseSize: 16,
                    isBold: false,
                    color: Colors.black,
                    isUrdu: isUrdu,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
