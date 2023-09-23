import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/widgets/app_icon.dart';
import 'package:rosary/widgets/big_text.dart';
import 'package:rosary/widgets/main_text.dart';

import '../controllers/main_controller.dart';

class PopUpPrayer extends StatelessWidget {
  PopUpPrayer({super.key});
  var _mainController = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (main) {
      return Scaffold(
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image:
                  AssetImage("assets/${_mainController.currentMysterBanner}"),
            ),
          ),
          child: Container(
            color: Colors.white.withOpacity(.85),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20.w,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: AppIcon(
                              icon: Icons.close,
                              backgroundColor: Colors.grey.shade300,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    MainText(
                      text: main.currentPrayer.title,
                      size: 24.sp,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Html(
                      data: main.currentPrayer.content.tr,
                      style: {
                        'p': Style(
                            fontSize: FontSize(18.sp), fontFamily: "Georgian"),
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: BigText(
                        text: 'click_to_close'.tr,
                        isBold: true,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
