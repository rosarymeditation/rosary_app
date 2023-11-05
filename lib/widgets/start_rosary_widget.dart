import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';
import 'main_text.dart';

class StartRosaryWidget extends StatelessWidget {
  const StartRosaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            AppConstant.getImagePath("rosary_back.jpeg"),
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50.sp),
          bottomRight: Radius.circular(50.sp),
        ),
      ),
      height: 200.h,
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
            height: 60.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.sp),
              color: const Color.fromARGB(132, 21, 101, 192),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      AppConstant.getImagePath("rosary.png"),
                    ),
                  ),
                  MainText(
                    text: 'start_rosary',
                    color: Colors.white,
                    size: 18.sp,
                    isBold: true,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.shade100,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
