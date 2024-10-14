import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HtmlWidget extends StatelessWidget {
  String data;
  HtmlWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Html(
      data: data.tr,
      style: {
        "h1": Style(
          fontSize: FontSize(18),
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.center,
          margin: Margins.only(bottom: 20),
        ),
        "h2": Style(
          fontSize: FontSize(18),
          fontWeight: FontWeight.w600,
          textAlign: TextAlign.center,
          margin: Margins.only(bottom: 15),
        ),
        "h3": Style(
          fontSize: FontSize(18),
          fontWeight: FontWeight.w600,
          margin: Margins.only(top: 20, bottom: 10),
          textAlign: TextAlign.left,
        ),
        "p": Style(
          fontSize: FontSize(13.sp),
          //color: Colors.black87,
          margin: Margins.only(bottom: 14),
        ),
        "strong": Style(
          fontWeight: FontWeight.bold,
          // color: Colors.black,
        ),
        "blockquote": Style(
          fontSize: FontSize.large,
          fontStyle: FontStyle.italic,
          //color: Colors.grey.shade700,
          padding: HtmlPaddings.symmetric(horizontal: 15, vertical: 10),
          backgroundColor: Colors.grey.shade200,
          border: const Border(left: BorderSide(color: Colors.teal, width: 4)),
          margin: Margins.symmetric(vertical: 20),
        ),
      },
    );
  }
}
