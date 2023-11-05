import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosary/widgets/big_text.dart';

import '../songs/play_list.dart';
import '../utils/constants.dart';
import 'main_text.dart';

class DashMenuWidget extends StatelessWidget {
  String title;
  String subTitle;
  Color iconColor;
  String? img;
  DashMenuWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.iconColor,
    this.img = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      height: 80.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white, // Set the background color of the container
        borderRadius:
            BorderRadius.circular(10), // Optional: Add rounded corners
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 80.h,
            width: 80.w,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: iconColor,
                image: DecorationImage(
                  image: AssetImage(
                    AppConstant.getImagePath(
                      img.toString(),
                    ),
                  ), // Replace with your own image path
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20.sp)),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10.w,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainText(
                      text: title,
                      size: 18.sp,
                      isBold: true,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    MainText(
                      align: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      text: subTitle,
                      size: 14.sp,
                      color: Colors.grey.shade500,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
