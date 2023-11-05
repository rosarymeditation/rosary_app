import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants.dart';
import '../utils/dimensions.dart';
import 'main_text.dart';

class InspirationWidget extends StatelessWidget {
  String title;
  String subTitle;
  String img;
  InspirationWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: Dimensions.screenWidth * 0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(
            AppConstant.getImagePath(img),
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainText(
            text: title,
            color: Colors.white,
            size: 18.sp,
            isBold: true,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: MainText(
              overflow: TextOverflow.ellipsis,
              text: subTitle,
              color: Colors.white,
              align: TextAlign.left,
              size: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
