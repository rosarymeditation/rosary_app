import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'main_text.dart';

class DashLabelWidget extends StatelessWidget {
  String title;
  DashLabelWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            color: Colors.grey.shade400,
          ),
          SizedBox(
            width: 10.w,
          ),
          MainText(
            text: title,
            size: 16.sp,
            isBold: true,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}
