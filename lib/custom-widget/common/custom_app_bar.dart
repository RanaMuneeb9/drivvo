import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final bool isUrdu;

  const CustomAppBar({super.key, required this.name, required this.isUrdu});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Utils.appColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      title: Text(
        name.tr,
        style: Utils.getTextStyle(
          baseSize: 18,
          isBold: true,
          color: Colors.white,
          isUrdu: isUrdu,
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
