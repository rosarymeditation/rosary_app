import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainText extends StatelessWidget {
  final String text;
  double size;
  Color color;
  bool? isBold;
  TextOverflow overflow;
  TextAlign align;

  MainText(
      {Key? key,
      this.color = const Color(0xFF332d2d),
      required this.text,
      this.size = 13,
      this.isBold = false,
      this.align = TextAlign.center,
      this.overflow = TextOverflow.clip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      removePTags(text.tr),
      textAlign: align,
      overflow: overflow,
      maxLines: 14,
      style: TextStyle(
        fontSize: size == 0 ? 20.sp : size,
        color: color,
        fontWeight: isBold! ? FontWeight.w800 : FontWeight.w400,
        fontFamily: "Georgian",
      ),
    );
  }

  String removePTags(String input) {
    return input.replaceAll(RegExp(r'<p>|<\/p>'), '');
  }
}
