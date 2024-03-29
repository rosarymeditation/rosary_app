import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:rosary/controllers/distress_controller.dart';
import 'package:rosary/route/route_helpers.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/utils/dimensions.dart';
import 'package:rosary/widgets/avatar_widget.dart';
import 'package:rosary/widgets/banner_widget.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:rosary/widgets/main_text.dart';
import 'package:rosary/widgets/name_widget.dart';
import 'package:rosary/widgets/prayer_banner_widget.dart';
import 'package:html/parser.dart' show parse;
import '../controllers/auth_controller.dart';
import '../controllers/langauge_controller.dart';
import '../controllers/prayer_controller.dart';
import '../controllers/user_controller.dart';
import '../utils/appColor.dart';
import '../widgets/expandable_text_widget.dart';

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

    // flutterTts.setStartHandler(() {
    //   setState(() {
    //     print("playing");
    //     ttsState = TtsState.playing;
    //   });
    // });

    flutterTts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
      });
    });
  }

  String removeHtmlTags(String htmlString) {
    final document = parse(htmlString);
    final text = parse(document.body!.text).documentElement!.text;
    return text;
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
                      Image.network(item.distress.url!),
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
    flutterTts.stop(); // Stop any ongoing speech
  }
}
