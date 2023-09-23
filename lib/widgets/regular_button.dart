import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rosary/widgets/main_text.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';

class RegularBtnWidget extends StatelessWidget {
  final String text;
  Color backgroundColor;
  RegularBtnWidget(
      {Key? key, required this.text, required this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height45,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: MainText(
          isBold: true,
          size: 18.sp,
          text: text,
          color: Colors.white,
        ),
      ),
    );
  }
}
