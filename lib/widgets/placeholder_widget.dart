import 'package:flutter/material.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/utils/dimensions.dart';

class PlaceholderWidget extends StatelessWidget {
  double height;
  String assetImage;
  bool isAvatar;
  double avatarSize;
  PlaceholderWidget(
      {super.key,
      this.height = 160,
      this.assetImage = "assets/images/catholic.jpg",
      this.isAvatar = false,
      this.avatarSize = 80});

  @override
  Widget build(BuildContext context) {
    return isAvatar
        ? ClipOval(
            child: Image.asset(
              AppConstant.DEFAULT_AVATAR,
              height: avatarSize,
              width: avatarSize,
              fit: BoxFit.cover,
            ),
          )
        : Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(
                Dimensions.radius15,
              ),
            ),
            width: double.maxFinite,
            height: height,
            child: Image.asset(
              AppConstant.getImagePath("blank.webp"),
              fit: BoxFit.cover,
            ),
          );
  }
}
