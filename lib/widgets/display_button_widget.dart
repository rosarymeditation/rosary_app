import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/widgets/main_text.dart';

class DisplayButtonWidget extends StatelessWidget {
  String text;
  Color color;
  bool hasIcon;
  String img;
  DisplayButtonWidget({
    super.key,
    required this.text,
    this.color = const Color(0xFF0077B6),
    this.hasIcon = false,
    this.img = "",
  });

  @override
  Widget build(BuildContext context) {
    return hasIcon
        ? Container(
            height: 50.h,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.sp),
              color: color,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 20.w,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage(AppConstant.getImagePath(img)),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Flexible(
                  child: MainText(
                    overflow: TextOverflow.ellipsis,
                    size: 18.sp,
                    text: text,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        : Container(
            height: 50.h,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20.sp),
            ),
            child: Center(
              child: MainText(
                text: text.tr,
                size: 18.sp,
                color: Colors.white,
              ),
            ),
          );
  }
}
