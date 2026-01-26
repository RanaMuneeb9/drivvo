import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';

class BuildLanguageOption extends StatelessWidget {
  final String languageName;
  final String country;
  final bool isSelected;
  final bool isUrdu;
  final VoidCallback onTap;

  const BuildLanguageOption({
    super.key,
    required this.languageName,
    required this.country,
    required this.isSelected,
    required this.isUrdu,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF00796B).withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF00796B)
                : Colors.grey.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                languageName.tr,
                style: Utils.getTextStyle(
                  baseSize: 16,
                  isBold: true,
                  color: isSelected ? const Color(0xFF00796B) : Colors.black,
                  isUrdu: isUrdu,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF00796B),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
