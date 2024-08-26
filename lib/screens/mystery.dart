import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/model/data.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/widgets/main_text.dart';
import '../controllers/main_controller.dart';
import '../main_screens/ad_mob_banner.dart';
import '../widgets/app_icon.dart';
import '../widgets/rosary_app_bar_widget.dart';

class MysteryScreen extends StatefulWidget {
  @override
  State<MysteryScreen> createState() => _MysteryScreenState();
}

class _MysteryScreenState extends State<MysteryScreen> {
  var _mainController = Get.find<MainController>();
  late PageController _pageController;

  late DataModel dataMystery;
  bool hasLoded = false;
  @override
  void initState() {
    // _prayerController.prayerRequestList();
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 1);
    print(_mainController.currentMystery);
    fetchData(
        _mainController.currentMyesteryCounter, _mainController.currentMystery);
  }

  @override
  Widget build(BuildContext context) {
    _mainController.getSingleMystery(
        mysteryType: _mainController.currentMystery, number: 1);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const RosaryAppBarWidget(text: ""),
      body: SizedBox(
        height: 700.h,
        child: PageView(
          controller: _pageController,
          onPageChanged: (value) {
            print(value);
            if (value == 0) {
              if (_mainController.currentMyesteryCounter == 1) {
                Get.toNamed(RouteHelpers.rosaryIntroPage);
              } else {
                _mainController.setBidFocus(11);
                _mainController.setMysteryCounterDecrement(1);
                Navigator.pop(context);
              }
              return;
            }
            if (value == 2) {
              _mainController.setBidFocus(0);
              Get.toNamed(RouteHelpers.chapletPage);
              return;
            }
          },
          children: <Widget>[
            Container(
              child: Center(
                child: Text(
                  '',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                color: Theme.of(context).colorScheme.background,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: !hasLoded
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/${dataMystery.banner}',
                              fit: BoxFit.cover,
                              width: double.maxFinite,
                              height: 200.h,
                            ),
                            MainText(
                              color: AppColor.subTitle,
                              text: dataMystery.title!.tr,
                              size: 22.sp,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              dataMystery.scripture!.tr,
                              style: TextStyle(
                                  fontSize: 15.sp, fontStyle: FontStyle.italic),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              dataMystery.name!.tr,
                              style: TextStyle(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Html(
                              data: dataMystery.text.toString().tr,
                              style: {
                                'p': Style(
                                    textAlign: TextAlign.left,
                                    fontSize: FontSize(18.sp),
                                    fontFamily: "Georgian"),
                              },
                            ),
                            const Divider(),
                            Text(
                              'relection'.tr,
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 16.h),
                            Html(
                              data: dataMystery.reflection.toString().tr,
                              style: {
                                'p': Style(
                                    fontSize: FontSize(18.sp),
                                    fontFamily: "Georgian"),
                              },
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
            Container(
              child: Center(
                child: Text(
                  '',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.tertiary,
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h, top: 20.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          InkWell(
            onTap: () {
              // Get.toNamed(RouteHelpers.progressPrayerPage);
              if (_mainController.currentMyesteryCounter == 1) {
                Get.toNamed(RouteHelpers.rosaryIntroPage);
              } else {
                _mainController.setBidFocus(11);
                _mainController.setMysteryCounterDecrement(1);
                Navigator.pop(context);
              }
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
              Get.toNamed(RouteHelpers.chapletPage);
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
  }

  fetchData(id, type) async {
    String data = await rootBundle.loadString('assets/data/mystery.json');
    var jsonResult = json.decode(data);

    for (var item in jsonResult["data"]) {
      if (item["id"] == id &&
          item["type"] == _mainController.formatMystery(type)) {
        dataMystery = DataModel.fromJson(item);
        _mainController.setMysteryBanner(banner: dataMystery.banner ?? "");
        setState(() {
          hasLoded = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
