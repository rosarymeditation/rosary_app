import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BigText extends StatelessWidget {
  final String text;
  double size;
  TextOverflow overflow;
  Color color;
  bool? isBold;
  TextAlign align;

  BigText(
      {Key? key,
      this.color = const Color(0xFF332d2d),
      required this.text,
      this.size = 13,
      this.isBold = false,
      this.align = TextAlign.left,
      this.overflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      maxLines: 4,
      overflow: overflow,
      softWrap: false,
      textAlign: align,
      style: TextStyle(
        fontFamily: "Georgian",
        color: color,
        fontSize: size == 0 ? 20.sp : size,
        fontWeight: isBold! ? FontWeight.w800 : FontWeight.w400,
      ),
    );
  }
}
