import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosary/widgets/main_text.dart';

class DonateBtnWidget extends StatelessWidget {
  const DonateBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.shade600,
        borderRadius: BorderRadius.circular(20.sp),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MainText(
            size: 16.sp,
            text: "Give Now",
            color: Colors.white,
            isBold: true,
          ),
          SizedBox(
            width: 10.w,
          ),
          CircleAvatar(
            radius: 20.sp,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.favorite,
              size: 20.sp,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
