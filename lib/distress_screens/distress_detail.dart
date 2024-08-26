import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:rosary/controllers/distress_controller.dart';
import 'package:rosary/widgets/distress_image.dart';
import 'package:rosary/widgets/main_text.dart';
import '../controllers/langauge_controller.dart';
import '../main_screens/ad_mob_banner.dart';

class DistressDetailScreen extends StatefulWidget {
  DistressDetailScreen({super.key});

  @override
  State<DistressDetailScreen> createState() => _PrayerDetailScreenState();
}

class _PrayerDetailScreenState extends State<DistressDetailScreen> {
  var _languageController = Get.find<LocalizationController>();
  String currentuserId = "";
  bool isSpeaking = false;
  // late TtsState ttsState;
  FlutterTts flutterTts = FlutterTts();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DistressController>(builder: (item) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              title: MainText(
                text: item.distress.title!,
                color: Colors.white,
                size: 17.sp,
              ),
              foregroundColor: Colors.black,
              expandedHeight: 40.h, // Max height when fully expanded
              floating: true, // Doesn't float above content
              pinned: true,
              backgroundColor: Theme.of(context)
                  .colorScheme
                  .secondary, // Stays pinned to the top
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  // Build your news article content here
                  return Column(
                    children: [
                      DistressImageWidget(imageUrl: item.distress.url!),
                      Container(
                        color: Theme.of(context).colorScheme.background,
                        child: Html(
                          data: item.distress.content ?? "",
                          style: {
                            'p': Style(
                                fontSize: FontSize(14.sp),
                                fontFamily: "Georgian"),
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      AdMobBanner(),
                    ],
                  );
                },
                childCount: 1, // Number of news articles
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
