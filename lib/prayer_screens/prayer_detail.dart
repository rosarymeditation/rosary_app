import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/utils/dimensions.dart';
import 'package:rosary/widgets/avatar_widget.dart';
import 'package:rosary/widgets/banner_widget.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:rosary/widgets/main_text.dart';
import 'package:rosary/widgets/name_widget.dart';
import 'package:rosary/widgets/prayer_banner_widget.dart';

import '../controllers/auth_controller.dart';
import '../controllers/prayer_controller.dart';
import '../controllers/user_controller.dart';
import '../utils/appColor.dart';
import '../widgets/expandable_text_widget.dart';

class PrayerDetailScreen extends StatefulWidget {
  PrayerDetailScreen({super.key});

  @override
  State<PrayerDetailScreen> createState() => _PrayerDetailScreenState();
}

class _PrayerDetailScreenState extends State<PrayerDetailScreen> {
  var _userController = Get.find<UserController>();
  var _authController = Get.find<AuthController>();
  String currentuserId = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrayerController>(builder: (item) {
      return Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: MainText(
              text: item.prayer.title!,
              color: Colors.white,
              size: 17.sp,
            ),
            foregroundColor: Colors.white,
            expandedHeight: 200.h, // Max height when fully expanded
            floating: true, // Doesn't float above content
            pinned: true,
            backgroundColor: AppColor.primaryColor, // Stays pinned to the top
            flexibleSpace: FlexibleSpaceBar(
                background: PrayerBannerWidget(item: item.prayer)),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                // Build your news article content here
                return Container(
                  decoration: BoxDecoration(
                    image: item.prayer.url == ""
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                AppConstant.getImagePath("pray.jpg")),
                          )
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(item.prayer.url!),
                          ),
                  ),
                  child: Container(
                    color: Colors.white.withOpacity(.85),
                    child: Html(
                      data: item.prayer.content,
                      style: {
                        'p': Style(
                            fontSize: FontSize(18.sp), fontFamily: "Georgian"),
                      },
                    ),
                  ),
                );
              },
              childCount: 1, // Number of news articles
            ),
          ),
        ],
      ));
    });
  }
}
