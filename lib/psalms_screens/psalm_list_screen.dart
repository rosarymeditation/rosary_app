import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/widgets/big_text.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:rosary/widgets/main_text.dart';

import '../controllers/psalm_controller.dart';
import '../route/route_helpers.dart';
import '../utils/constants.dart';

class PsalmListScreen extends StatefulWidget {
  const PsalmListScreen({super.key});

  @override
  State<PsalmListScreen> createState() => _PsalmListScreenState();
}

class _PsalmListScreenState extends State<PsalmListScreen> {
  var _psalmController = Get.find<PsalmController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _psalmController.getPsalmList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.yellow.shade100,
      appBar: MainAppBarWidget(text: "powerful_psalms"),
      body: Container(
        margin: EdgeInsets.only(top: 20.h),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        width: double.maxFinite,
        child: GetBuilder<PsalmController>(builder: (psalm) {
          int itemLength = psalm.psalmList.length;
          return itemLength > 0
              ? ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: psalm.psalmList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var item = psalm.psalmList[index];

                    return InkWell(
                        onTap: () {
                          psalm.setPsalm(item);
                          Get.toNamed(RouteHelpers.psalmDetailPage);
                        },
                        child: Column(
                          children: [_titleWidget(item.title!), Divider()],
                        ));
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
        Flexible(
          child: Html(
            data: title,
            style: {
              'span': Style(
                fontSize: FontSize(16.sp),
                fontFamily: "Georgian",
              ),
            },
          ),
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
                _psalmController.getPsalmList();
              },
              child: MainText(text: "refresh"))
        ],
      ),
    );
  }
}
