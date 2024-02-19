import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/widgets/main_text.dart';

import '../utils/appColor.dart';
import '../widgets/app_icon.dart';

class StationPage extends StatefulWidget {
  const StationPage({super.key});

  @override
  State<StationPage> createState() => _StationPageState();
}

class _StationPageState extends State<StationPage> {
  var key1 = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  var textVal = "station_0";
  var pageVal = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              AppConstant.getImagePath("$pageVal.jpeg"),
              key: key1,
            ),
            Html(
              data: textVal.toString().tr,
              style: {
                'p': Style(fontSize: FontSize(18.sp), fontFamily: "Georgian"),
              },
            ),
            pageVal == 14
                ? Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: MainText(
                          text: "finish".tr,
                          size: 16.sp,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            pageVal = 0;
                          });
                          Scrollable.ensureVisible(key1.currentContext!);
                        },
                        child: MainText(
                          text: "restart".tr,
                          size: 16.sp,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      )
                    ],
                  )
                : Text("")
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.tertiary,
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h, top: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                if (pageVal <= 0) {
                  Navigator.of(context).pop();
                  setState(() {
                    pageVal = 0;
                  });
                  return;
                }
                pageVal--;
                setState(() {
                  textVal = "station_" + pageVal.toString();
                });
                Scrollable.ensureVisible(key1.currentContext!);
              },
              child: AppIcon(
                backgroundColor: AppColor.iconColor,
                iconColor: Colors.white,
                icon: Icons.arrow_back_sharp,
                iconSize: 40.sp,
                size: 60.sp,
              ),
            ),
            pageVal == 14
                ? Text("")
                : InkWell(
                    onTap: () {
                      if (pageVal >= 14) {
                        return;
                      }
                      Scrollable.ensureVisible(key1.currentContext!);
                      pageVal++;
                      setState(() {
                        textVal = "station_" + pageVal.toString();
                      });
                    },
                    child: AppIcon(
                      backgroundColor: AppColor.iconColor,
                      iconColor: Colors.white,
                      icon: Icons.arrow_forward_sharp,
                      iconSize: 40.sp,
                      size: 60.sp,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
