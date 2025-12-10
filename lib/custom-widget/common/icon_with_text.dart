import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';

class IconWithText extends StatelessWidget {
  final String title;
  final bool isUrdu;
  final Color textColor;
  final String imagePath;

  const IconWithText({
    super.key,
    required this.title,
    required this.isUrdu,
    required this.textColor,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: 20),
        SizedBox(width: 6),
        Text(
          title,
          style: Utils.getTextStyle(
            baseSize: 18,
            isBold: true,
            color: textColor,
            isUrdu: isUrdu,
          ),
        ),
      ],
    );
  }
}
