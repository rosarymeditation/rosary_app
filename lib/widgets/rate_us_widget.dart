import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';

import '../utils/constants.dart';
import 'main_text.dart';

class RateUsWidget extends StatelessWidget {
  const RateUsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        LaunchReview.launch(
          androidAppId: "com.rosarysoftnergy.app",
          iOSAppId: "6463201997",
        );
      },
      child: Container(
        height: 60.h,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.red,
              radius: 16.r,
              backgroundImage: AssetImage(
                AppConstant.getImagePath("prayer_request.png"),
              ),
            ),
            Flexible(
              child: Column(
                children: [
                  Expanded(
                    child: MainText(
                      text: "like_our_app".tr,
                      isBold: true,
                      size: 17.sp,
                    ),
                  ),
                  MainText(
                    text: "rate_5_star".tr,
                    size: 14.sp,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: MainText(text: "rate_us".tr, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
