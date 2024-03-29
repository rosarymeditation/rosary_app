import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/widgets/big_text.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:rosary/widgets/main_text.dart';

import '../controllers/prayer_controller.dart';
import '../controllers/psalm_controller.dart';
import '../route/route_helpers.dart';
import '../utils/constants.dart';

class NovenaListScreen extends StatefulWidget {
  const NovenaListScreen({super.key});

  @override
  State<NovenaListScreen> createState() => _PsalmListScreenState();
}

class _PsalmListScreenState extends State<NovenaListScreen> {
  var _prayerController = Get.find<PrayerController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _prayerController.getNovenaPrayerList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: MainAppBarWidget(text: "powerful_novena"),
      body: Container(
        margin: EdgeInsets.only(top: 20.h),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        width: double.maxFinite,
        child: GetBuilder<PrayerController>(builder: (prayer) {
          int itemLength = prayer.novenaPrayerList.length;
          return itemLength > 0
              ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: prayer.novenaPrayerList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var item = prayer.novenaPrayerList[index];

                    return InkWell(
                      onTap: () {
                        prayer.setPrayer(item);
                        Get.toNamed(RouteHelpers.novenaDetailPage);
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: _titleWidget(item.title!),
                          ),
                          Divider()
                        ],
                      ),
                    );
                  },
                )
              : Center(child: timeoutWidget());
        }),
      ),
    );
  }

  Widget _titleWidget(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MainText(
          color: AppColor.subTitle,
          text: title,
          size: 16.sp,
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey.shade400,
        ),
      ],
    );
  }

  Widget timeoutWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainText(
            size: 18.sp,
            text: AppConstant.NETWORK_TIMEOUT_MESSAGE.tr,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                _prayerController.getNovenaPrayerList();
              },
              child: MainText(text: "refresh"))
        ],
      ),
    );
  }
}
