import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rosary/controllers/feedComment_controller.dart';
import 'package:rosary/controllers/prayer_controller.dart';
import 'package:rosary/widgets/chat_text_field.dart';
import 'package:rosary/widgets/feed_item_widget.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:rosary/widgets/main_text.dart';
import 'package:rosary/widgets/prayer_banner_widget.dart';
import '../controllers/distress_controller.dart';
import '../controllers/feed_controller.dart';
import '../controllers/network_controller.dart';
import '../route/route_helpers.dart';
import '../utils/appColor.dart';
import '../utils/constants.dart';
import '../utils/dimensions.dart';

class DistressScreen extends StatefulWidget {
  DistressScreen({super.key});

  @override
  State<DistressScreen> createState() => _PrayersScreenState();
}

class _PrayersScreenState extends State<DistressScreen> {
  var _distressController = Get.find<DistressController>();

  var textController = TextEditingController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    _distressController.getDistressList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DistressController>(
      builder: (distress) {
        return Scaffold(
            appBar: MainAppBarWidget(text: "finding_comfort".tr),
            backgroundColor: Theme.of(context).colorScheme.background,
            body: distress.distressList.isNotEmpty
                ? SmartRefresher(
                    enablePullUp: true,
                    header: const WaterDropHeader(),
                    controller: _refreshController,
                    onRefresh: () async {
                      distress.getDistressList();
                      await Future.delayed(
                        Duration(seconds: 0, milliseconds: 2000),
                      );
                      if (distress.isLoaded)
                        _refreshController.refreshCompleted();
                      else
                        _refreshController.refreshFailed();
                    },
                    onLoading: () async {
                      distress.loadMore();

                      await Future.delayed(
                        Duration(seconds: 0, milliseconds: 2000),
                      );
                      if (distress.isMoreLoaded)
                        _refreshController.loadComplete();
                      else
                        _refreshController.loadFailed();
                    },
                    child: GetBuilder<DistressController>(builder: (distress) {
                      int itemLength = distress.distressList.length;
                      return itemLength > 0
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: distress.distressList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var item = distress.distressList[index];

                                  return InkWell(
                                    onTap: () {
                                      distress.setDistress(item);
                                      Get.toNamed(
                                          RouteHelpers.distressDetailPage);
                                    },
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: _titleWidget(item.title!),
                                        ),
                                        Divider()
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: timeoutWidget(),
                            );
                    }),
                  )
                : const Center(child: CircularProgressIndicator()));
      },
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
                _distressController.getDistressList();
              },
              child: MainText(text: "refresh"))
        ],
      ),
    );
  }
  // @override
  // void dispose() {
  //   // Dispose of the controller when the widget is removed
  //   _feedController.dispose();
  //   super.dispose();
  // }
}
