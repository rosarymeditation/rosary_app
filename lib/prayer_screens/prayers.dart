import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rosary/controllers/feedComment_controller.dart';
import 'package:rosary/controllers/prayer_controller.dart';
import 'package:rosary/screens/no_network.dart';
import 'package:rosary/widgets/chat_text_field.dart';
import 'package:rosary/widgets/feed_item_widget.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:rosary/widgets/main_text.dart';
import 'package:rosary/widgets/prayer_banner_widget.dart';
import '../controllers/feed_controller.dart';
import '../controllers/network_controller.dart';
import '../route/route_helpers.dart';
import '../utils/appColor.dart';
import '../utils/constants.dart';
import '../utils/dimensions.dart';

class PrayersScreen extends StatefulWidget {
  PrayersScreen({super.key});

  @override
  State<PrayersScreen> createState() => _PrayersScreenState();
}

class _PrayersScreenState extends State<PrayersScreen> {
  var _prayerController = Get.find<PrayerController>();

  var textController = TextEditingController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    if (_prayerController.prayerType == AppConstant.PRAYER_TYPE_OTHERS)
      _prayerController.getPrayerList();
    else
      _prayerController.getCatholicPrayerList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrayerController>(
      builder: (prayer) {
        return prayer.prayerType == AppConstant.PRAYER_TYPE_OTHERS
            ? Scaffold(
                appBar: MainAppBarWidget(text: "General Prayers"),
                backgroundColor: Theme.of(context).colorScheme.background,
                body: prayer.isLoaded
                    ? SmartRefresher(
                        enablePullUp: true,
                        header: const WaterDropHeader(),
                        controller: _refreshController,
                        onRefresh: () async {
                          prayer.getPrayerList();
                          await Future.delayed(
                            Duration(seconds: 0, milliseconds: 2000),
                          );
                          if (prayer.isLoaded)
                            _refreshController.refreshCompleted();
                          else
                            _refreshController.refreshFailed();
                        },
                        onLoading: () async {
                          prayer.loadMore();

                          await Future.delayed(
                            Duration(seconds: 0, milliseconds: 2000),
                          );
                          if (prayer.isMoreLoaded)
                            _refreshController.loadComplete();
                          else
                            _refreshController.loadFailed();
                        },
                        child: GetBuilder<PrayerController>(builder: (prayer) {
                          int itemLength = prayer.otherPrayerList.length;
                          return itemLength > 0
                              ? ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: prayer.otherPrayerList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var item = prayer.otherPrayerList[index];

                                    return InkWell(
                                        onTap: () {
                                          prayer.setPrayer(item);
                                          Get.toNamed(
                                              RouteHelpers.prayerDetailPage);
                                        },
                                        child: PrayerBannerWidget(item: item));
                                  },
                                )
                              : Center(
                                  child: timeoutWidget(),
                                );
                        }),
                      )
                    : const Center(child: CircularProgressIndicator()))
            : Scaffold(
                appBar: MainAppBarWidget(text: "Catholic Prayers"),
                backgroundColor: Theme.of(context).colorScheme.background,
                body: prayer.isLoaded
                    ? SmartRefresher(
                        enablePullUp: true,
                        header: const WaterDropHeader(),
                        controller: _refreshController,
                        onRefresh: () async {
                          prayer.getCatholicPrayerList();
                          await Future.delayed(
                            Duration(seconds: 0, milliseconds: 2000),
                          );
                          if (prayer.isLoaded)
                            _refreshController.refreshCompleted();
                          else
                            _refreshController.refreshFailed();
                        },
                        onLoading: () async {
                          prayer.loadMoreCatholic();

                          await Future.delayed(
                            Duration(seconds: 0, milliseconds: 2000),
                          );
                          if (prayer.isMoreLoaded)
                            _refreshController.loadComplete();
                          else
                            _refreshController.loadFailed();
                        },
                        child: GetBuilder<PrayerController>(builder: (prayer) {
                          int itemLength = prayer.catholicPrayerList.length;
                          return itemLength > 0
                              ? ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: prayer.catholicPrayerList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var item = prayer.catholicPrayerList[index];

                                    return InkWell(
                                        onTap: () {
                                          prayer.setPrayer(item);
                                          Get.toNamed(
                                              RouteHelpers.prayerDetailPage);
                                        },
                                        child: PrayerBannerWidget(item: item));
                                  },
                                )
                              : Center(child: timeoutWidget());
                        }),
                      )
                    : const Center(child: CircularProgressIndicator()));
      },
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
                _prayerController.getCatholicPrayerList();
                _prayerController.getPrayerList();
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
