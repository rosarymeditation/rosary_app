import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/widgets/big_text.dart';

import '../songs/play_list.dart';
import '../utils/constants.dart';
import '../utils/dimensions.dart';
import 'main_text.dart';

class DashSimpleWidget extends StatelessWidget {
  String title;
  String subTitle;
  DashSimpleWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.maxFinite,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/solace.jpeg"),
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        height: 120.h,
        width: double.maxFinite,
        child: Container(
          color: Colors.black.withOpacity(0.4),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainText(
                  align: TextAlign.left,
                  text: title,
                  size: 18.sp,
                  isBold: true,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 5,
                ),
                MainText(
                  align: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  text: subTitle,
                  size: 14.sp,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
