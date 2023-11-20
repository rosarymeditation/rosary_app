import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/widgets/big_text.dart';

import '../songs/play_list.dart';
import '../utils/constants.dart';
import 'main_text.dart';

class DashAudioWidget extends StatelessWidget {
  String title;
  String subTitle;
  IconData icon;
  Color iconColor;
  String? img;
  int? num;
  DashAudioWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.iconColor,
    this.img = "",
    this.num = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .tertiary, // Set the background color of the container
        borderRadius:
            BorderRadius.circular(10), // Optional: Add rounded corners
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 10.w,
              ),
              CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                radius: 30.sp,
                child: img == ""
                    ? Icon(
                        icon,
                        size: 40.sp,
                        color: iconColor,
                      )
                    : CircleAvatar(
                        radius: 33.sp,
                        backgroundImage: AssetImage(
                          AppConstant.getImagePath(
                            img.toString(),
                          ),
                        ),
                      ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MainText(
                        align: TextAlign.left,
                        text: title,
                        size: 16.sp,
                        isBold: true,
                        color: AppColor.title),
                    const SizedBox(
                      height: 5,
                    ),
                    MainText(
                        align: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        text: subTitle,
                        size: 14.sp,
                        color: AppColor.subTitle),
                  ],
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 15.w,
                    child: Text(
                      num.toString(),
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
