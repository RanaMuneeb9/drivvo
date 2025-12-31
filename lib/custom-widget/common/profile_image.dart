import 'package:drivvo/custom-widget/common/profile_network_image.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final double width;
  final double height;
  final String photoUrl;
  final double radius;
  final String placeholder;
  final bool view;

  const ProfileImage({
    super.key,
    required this.photoUrl,
    required this.width,
    required this.height,
    required this.radius,
    required this.placeholder,
    this.view = true,
  });

  @override
  Widget build(BuildContext context) {
    final isNetwork = photoUrl.startsWith('http');

    return GestureDetector(
      onTap: isNetwork ? () {} : null,
      child: isNetwork
          ? ProfileNetworkImage(
              imageUrl: photoUrl,
              width: width,
              height: height,
              borderRadius: radius,
              placeholder: placeholder,
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  border: Border.all(color: Utils.appColor, width: 2),
                ),
                child: Icon(Icons.person, color: Utils.appColor, size: 60),
              ),
              // Image.asset(
              //   photoUrl,
              //   width: width,
              //   height: height,
              //   fit: BoxFit.cover,
              //   errorBuilder: (context, error, stackTrace) => Image.asset(
              //     placeholder,
              //     width: width,
              //     height: height,
              //     fit: BoxFit.cover,
              //   ),
              // ),
            ),
    );
  }
}
