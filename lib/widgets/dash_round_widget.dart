import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
      width: Dimensions.screenWidth * 0.31,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(20.sp),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        children: [
          // CircleAvatar(
          //   radius: Dimensions.screenWidth * 0.1,
          //   backgroundColor: Theme.of(context).colorScheme.secondary,
          //   child: CircleAvatar(
          //     radius: Dimensions.screenWidth * 0.1,
          //     backgroundImage: AssetImage(AppConstant.getImagePath(img)),
          //   ),
          // ),
          Container(
            width: double.infinity,
            height: 100.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(20.sp),
              image: DecorationImage(
                // Specify the image to be used
                image: AssetImage(AppConstant.getImagePath(img)),
                // Set how the image should be positioned within the container
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Image.asset(
          //   fit: BoxFit.cover,
          //   AppConstant.getImagePath(img),
          //   height: 100,
          // ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Text(
              title.tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
              ),
            ),
          )
          // MainText(
          //   align: TextAlign.center,
          //   color: AppColor.title,
          //   text: title,
          //   size: 9.sp,
          //   isBold: true,
          // )
        ],
      ),
    );
  }
}
