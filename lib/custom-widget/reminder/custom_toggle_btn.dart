import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomToggleBtn extends StatelessWidget {
  final String label;
  final int index;
  final int selectedIndex;
  final bool isUrdu;
  final VoidCallback onTap;

  const CustomToggleBtn({
    super.key,
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.isUrdu,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        decoration: BoxDecoration(
          color: isSelected ? Utils.appColor : Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            label,
            style: Utils.getTextStyle(
              baseSize: 14,
              isBold: false,
              color: isSelected ? Colors.white : Colors.grey,
              isUrdu: isUrdu,
            ),
          ),
        ),
      ),
    );
  }
}
