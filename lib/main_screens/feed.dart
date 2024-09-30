import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rosary/widgets/chat_text_field.dart';
import 'package:rosary/widgets/feed_item_widget.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import '../controllers/feed_controller.dart';
import '../route/route_helpers.dart';
import '../utils/dimensions.dart';

class FeedScreen extends StatefulWidget {
  FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  var _feedController = Get.find<FeedController>();

  var textController = TextEditingController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _feedController.getFeedList();
    // _verseController.getDailyVerse();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedController>(
      builder: (feeds) {
        return Scaffold(
          appBar: MainAppBarWidget(
            text: "Community",
            hasBackBtn: false,
          ),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          body: feeds.feedList.isNotEmpty
              ? SmartRefresher(
                  enablePullUp: true,
                  header: WaterDropHeader(),
                  controller: _refreshController,
                  onRefresh: () async {
                    feeds.getFeedList();
                    await Future.delayed(
                      Duration(seconds: 0, milliseconds: 2000),
                    );
                    if (feeds.isLoaded)
                      _refreshController.refreshCompleted();
                    else
                      _refreshController.refreshFailed();
                  },
                  onLoading: () async {
                    feeds.loadMore();

                    // _shopController.setOffset(offset);
                    // _shopController.getRestaurantLoadMoreList(
                    //   offset,
                    //   limit,
                    //   search,
                    //   category,
                    // );
                    await Future.delayed(
                      Duration(seconds: 0, milliseconds: 2000),
                    );
                    if (feeds.isMoreLoaded)
                      _refreshController.loadComplete();
                    else
                      _refreshController.loadFailed();
                  },
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        toolbarHeight: 80.h,
                        elevation: 0,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 10.h,
                                ),
                                Stack(children: [
                                  ChatTextField(
                                      textController: textController,
                                      hintText: "Write a post"),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(RouteHelpers.feedPostPage);
                                    },
                                    child: SizedBox(
                                      width: double.maxFinite,
                                      height: 50.h,
                                    ),
                                  )
                                ]),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            )
                          ],
                        ),
                        floating: true,
                        expandedHeight: Dimensions.height80,
                      ),
                      buildImages(),
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
    // : NoCommunityScreen();
  }

  Widget buildImages() => SliverToBoxAdapter(
        child: GetBuilder<FeedController>(builder: (feed) {
          int itemLength = feed.feedList.length;
          return Column(
            children: [
              ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: feed.feedList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item = feed.feedList[index];

                  return FeedItemWidget(item: item);
                },
              ),
            ],
          );
        }),
      );
}
