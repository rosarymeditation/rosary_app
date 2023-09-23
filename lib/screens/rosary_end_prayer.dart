import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/widgets/big_text.dart';
import 'package:rosary/widgets/main_text.dart';
import 'package:rosary/widgets/prayer_title_widget.dart';

import '../controllers/main_controller.dart';
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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/rosary.jpeg"),
              ),
            ),
            child: Container(
              color: Colors.white.withOpacity(.85),
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: 200.h,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                AssetImage(AppConstant.IMG_PATH + "mary.jpeg"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Column(
                        children: [
                          PrayerTitleWidget(
                            prayer: hailHolyQueenPrayer,
                            title: "hail_holy_queen_title".tr,
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          PrayerTitleWidget(
                            prayer: loretoLitany,
                            title: "loreto_litany_title".tr,
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          InkWell(
                            onTap: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text(''),
                                  content: Text("prayer_for_pope".tr),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: MainText(
                                    isBold: true,
                                    text: "prayer_for_pope",
                                    size: 20.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          PrayerTitleWidget(
                            prayer: ourFather,
                            title: "our_father_title".tr,
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          PrayerTitleWidget(
                            prayer: hailMary,
                            title: "hail_mary_title".tr,
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          MainText(
                            size: 20.sp,
                            text: "glory_to_father".tr,
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          MainText(
                            text: "name_of_father",
                            size: 18.sp,
                            color: Colors.red,
                            isBold: true,
                          ),
                        ],
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
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 30.h),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
              onTap: () {
                main.setStoredMysteryCounter(5);
                main.setBidFocus(11);
                Get.toNamed(RouteHelpers.chapletPage);
              },
              child: AppIcon(
                iconColor: Colors.white,
                backgroundColor: AppColor.primaryColor,
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
                iconColor: Colors.white,
                backgroundColor: AppColor.primaryColor,
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
