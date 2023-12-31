import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/utils/dimensions.dart';

import '../utils/constants.dart';
import 'main_text.dart';

class DashRoundWidget extends StatelessWidget {
  String title;
  String img;
  DashRoundWidget({super.key, required this.title, required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(10.sp),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        children: [
          CircleAvatar(
            radius: Dimensions.screenWidth * 0.19,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: CircleAvatar(
              radius: Dimensions.screenWidth * 0.18,
              backgroundImage: AssetImage(AppConstant.getImagePath(img)),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          MainText(
            color: AppColor.title,
            text: title,
            size: 14.sp,
            isBold: true,
          )
        ],
      ),
    );
  }
}
