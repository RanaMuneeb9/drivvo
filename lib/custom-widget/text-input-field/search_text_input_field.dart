import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchTextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintKey;
  final bool isUrdu;

  const SearchTextInputField({
    super.key,
    required this.controller,
    required this.hintKey,
    required this.isUrdu,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: Get.mediaQuery.size.width * 0.9,
      child: TextFormField(
        controller: controller,
        style: Utils.getTextStyle(
          baseSize: 14,
          isBold: false,
          color: Colors.black,
          isUrdu: isUrdu,
        ),
        decoration: InputDecoration(
          filled: true,
          hintText: hintKey.tr,
          prefixIcon: const Icon(Icons.search, size: 24),
          contentPadding: const EdgeInsets.all(0),
          fillColor: const Color(0xFFE6E5E5),
          isDense: true,
          errorStyle: Utils.getTextStyle(
            baseSize: 14,
            isBold: false,
            color: Colors.red,
            isUrdu: isUrdu,
          ),
          hintStyle: const TextStyle(color: Color(0xFF8B8B8F)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
