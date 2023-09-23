import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app_icon.dart';
import 'big_text.dart';

class AccountWidget extends StatelessWidget {
  String text;
  IconData leftIcon;
  Color iconBackgroundColor;
  bool hasArrow;
  AccountWidget(
      {Key? key,
      required this.text,
      required this.iconBackgroundColor,
      required this.leftIcon,
      this.hasArrow = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            AppIcon(
              backgroundColor: iconBackgroundColor,
              iconColor: Colors.white,
              icon: leftIcon,
              size: 40,
              iconSize: 30,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              text.tr,
              style: TextStyle(
                fontSize: 17.sp,
              ),
            ),
          ],
        ),
        hasArrow ? Icon(Icons.arrow_forward_ios) : Container()
      ],
    );
  }
}
