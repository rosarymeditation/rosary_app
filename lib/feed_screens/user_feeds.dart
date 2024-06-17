import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rosary/controllers/feedComment_controller.dart';
import 'package:rosary/widgets/chat_text_field.dart';
import 'package:rosary/widgets/feed_item_widget.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import '../controllers/feed_controller.dart';
import '../controllers/network_controller.dart';
import '../route/route_helpers.dart';
import '../utils/appColor.dart';
import '../utils/dimensions.dart';

class UserFeedScreen extends StatefulWidget {
  UserFeedScreen({super.key});

  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen> {
  var _feedController = Get.find<FeedController>();

  var textController = TextEditingController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    _feedController.getUserFeedList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeedController>(
      builder: (feeds) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: MainAppBarWidget(text: "My Posts"),
          body: feeds.isLoaded
              ? SmartRefresher(
                  enablePullUp: true,
                  header: const WaterDropHeader(),
                  controller: _refreshController,
                  onRefresh: () async {
                    feeds.getUserFeedList();
                    await Future.delayed(
                      Duration(seconds: 0, milliseconds: 2000),
                    );
                    if (feeds.isLoaded)
                      _refreshController.refreshCompleted();
                    else
                      _refreshController.refreshFailed();
                  },
                  onLoading: () async {
                    feeds.loadMoreUserFeed();

                    await Future.delayed(
                      Duration(seconds: 0, milliseconds: 2000),
                    );
                    if (feeds.isMoreLoaded)
                      _refreshController.loadComplete();
                    else
                      _refreshController.loadFailed();
                  },
                  child: GetBuilder<FeedController>(builder: (feed) {
                    int itemLength = feed.feedList.length;
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: feed.feedList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var item = feed.feedList[index];

                        return FeedItemWidget(
                          item: item,
                          isForProfile: true,
                        );
                      },
                    );
                  }),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }

  // @override
  // void dispose() {
  //   // Dispose of the controller when the widget is removed
  //   _feedController.dispose();
  //   super.dispose();
  // }
}
