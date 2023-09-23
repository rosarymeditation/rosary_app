import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {
  final String text;
  double size;
  Color color;
  double height;
  int maxLine;

  SmallText(
      {Key? key,
      required this.text,
      this.size = 12,
      this.maxLine = 1,
      this.color = const Color(0xFFccc7c5),
      this.height = 1.2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      // textAlign: TextAlign.center,
      maxLines: maxLine,
      style: TextStyle(
        fontFamily: 'Georgian',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
