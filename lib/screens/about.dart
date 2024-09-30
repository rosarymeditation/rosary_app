import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/utils/constants.dart';

import '../main_screens/ad_mob_banner.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('about_us'.tr),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Html(
          data: "about_content".tr,
          style: {
            'ul': Style(fontSize: FontSize(18.sp), fontFamily: "Georgian"),
            'p': Style(fontSize: FontSize(18.sp), fontFamily: "Georgian"),
          },
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 8.0),
          Text("•", style: TextStyle(fontSize: 16.0)),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 4.0),
                Text(content, style: TextStyle(fontSize: 16.0)),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
