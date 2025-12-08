import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final bool isUrdu;
  final Color? bgColor;
  final Color textColor;
  final Color? arrowColor;
  final bool? centerTitle;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.name,
    required this.isUrdu,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
    this.centerTitle = false,
    this.arrowColor = Colors.white,
    this.actions = const [SizedBox()],
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: bgColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back, color: arrowColor),
      ),
      title: Text(
        name.tr,
        style: Utils.getTextStyle(
          baseSize: 18,
          isBold: true,
          color: textColor,
          isUrdu: isUrdu,
        ),
      ),
      centerTitle: centerTitle,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
