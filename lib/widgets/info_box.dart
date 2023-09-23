import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'main_text.dart';

class InfoBoxWidget extends StatelessWidget {
  String text;
  InfoBoxWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5),
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20.sp),
      ),
      height: 50.h,
      width: double.infinity,
      child: Center(
        child: MainText(color: Colors.orange.shade700, size: 12.sp, text: text),
      ),
    );
  }
}
