import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/widgets/big_text.dart';
import 'package:rosary/widgets/main_text.dart';
import 'package:rosary/widgets/prayer_title_widget.dart';

import '../controllers/main_controller.dart';
import '../main_screens/ad_mob_banner.dart';
import '../widgets/app_icon.dart';

class RosaryEndPrayerScreen extends StatefulWidget {
  @override
  State<RosaryEndPrayerScreen> createState() => _RosaryEndPrayerScreenState();
}

class _RosaryEndPrayerScreenState extends State<RosaryEndPrayerScreen> {
  var hailHolyQueenPrayer = AppConstant.HAIL_HOLY_QUEEN;

  var fatimaPrayer = AppConstant.FATIMA;

  var loretoLitany = AppConstant.LORETO_LITANY;

  var ourFather = AppConstant.OUR_FATHER;

  var hailMary = AppConstant.HAIL_MARY;

  var gloryBeToFather = AppConstant.GLORY_BE_TO_FATHER;

  var _mainController = Get.find<MainController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainController.cacheLastScreenName(RouteHelpers.endPrayerPage);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (main) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(),
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      Column(
                        children: [
                          Html(
                            data: "closing_prayer".tr,
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
                                fontSize: FontSize(18),
                                lineHeight: LineHeight(1.7),
                                textAlign: TextAlign.justify,
                                //color: Colors.black87,
                                margin: Margins.only(bottom: 15),
                              ),
                              "strong": Style(
                                fontWeight: FontWeight.bold,
                                // color: Colors.black,
                              ),
                              "div": Style(
                                margin: Margins.symmetric(vertical: 20),
                                padding: HtmlPaddings.symmetric(horizontal: 10),
                              ),
                              "blockquote": Style(
                                fontSize: FontSize.large,
                                fontStyle: FontStyle.italic,
                                //color: Colors.grey.shade700,
                                padding: HtmlPaddings.symmetric(
                                    horizontal: 15, vertical: 10),
                                backgroundColor: Colors.grey.shade200,
                                border: const Border(
                                    left: BorderSide(
                                        color: Colors.teal, width: 4)),
                                margin: Margins.symmetric(vertical: 20),
                              ),
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      AdMobBanner(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).colorScheme.tertiary,
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30.h),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
              onTap: () {
                main.setStoredMysteryCounter(5);
                main.setBidFocus(11);
                Navigator.pop(context);
                //Get.toNamed(RouteHelpers.chapletPage);
              },
              child: AppIcon(
                backgroundColor: AppColor.iconColor,
                iconColor: Colors.white,
                icon: Icons.arrow_back_sharp,
                iconSize: 40.sp,
                size: 60.sp,
              ),
            ),
            InkWell(
              onTap: () {
                _mainController.setBidFocus(0);
                main.reset();
                Get.toNamed(RouteHelpers.rosaryCompletionPage);
              },
              child: AppIcon(
                backgroundColor: AppColor.iconColor,
                iconColor: Colors.white,
                icon: Icons.arrow_forward_sharp,
                iconSize: 40.sp,
                size: 60.sp,
              ),
            ),
          ]),
        ),
      );
    });
  }
}
