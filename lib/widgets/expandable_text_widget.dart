import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/appColor.dart';
import '../utils/dimensions.dart';
import 'small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  final Color color;
  const ExpandableTextWidget(
      {Key? key, required this.text, this.color = Colors.grey})
      : super(key: key);

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableText(
      style: TextStyle(
        color: Theme.of(context).colorScheme.inversePrimary,
        fontFamily: "Georgian",
        fontSize: 14.sp,
      ),
      widget.text,
      expandText: 'show more',
      collapseText: 'show less',
      maxLines: 4,
      linkColor: Theme.of(context).colorScheme.inversePrimary,
      animation: true,
      collapseOnTextTap: true,
    );
  }
  // Widget build(BuildContext context) {
  //   return Container(
  //     child: secondHalf.isEmpty
  //         ? SmallText(
  //             height: 1.8,
  //             text: firstHalf,
  //             size: 14.sp,
  //             color: Colors.black,
  //           )
  //         : Column(
  //             children: [
  //               SmallText(
  //                 maxLine: 30,
  //                 height: 1.8,
  //                 text:
  //                     hiddenText ? (firstHalf + "...") : firstHalf + secondHalf,
  //                 size: 14.sp,
  //                 color: Colors.black,
  //               ),
  //               InkWell(
  //                 onTap: () {
  //                   setState(() {
  //                     hiddenText = !hiddenText;
  //                   });
  //                 },
  //                 child: Row(children: [
  //                   SmallText(
  //                     maxLine: 30,
  //                     text: hiddenText ? "Show more" : "Show less",
  //                     size: 14.sp,
  //                     color: AppColor.primaryColor,
  //                   ),
  //                   Icon(
  //                     hiddenText ? Icons.arrow_drop_down : Icons.arrow_drop_up,
  //                     color: AppColor.primaryColor,
  //                   )
  //                 ]),
  //               )
  //             ],
  //           ),
  //   );
  // }
}
