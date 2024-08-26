import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
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
import 'package:html/parser.dart' show parse;
import '../controllers/auth_controller.dart';
import '../controllers/langauge_controller.dart';
import '../controllers/prayer_controller.dart';
import '../controllers/user_controller.dart';
import '../main_screens/ad_mob_banner.dart';
import '../utils/appColor.dart';
import '../widgets/expandable_text_widget.dart';

class PrayerDetailScreen extends StatefulWidget {
  PrayerDetailScreen({super.key});

  @override
  State<PrayerDetailScreen> createState() => _PrayerDetailScreenState();
}

class _PrayerDetailScreenState extends State<PrayerDetailScreen> {
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
    return GetBuilder<PrayerController>(builder: (item) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
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
              backgroundColor: Theme.of(context)
                  .colorScheme
                  .background, // Stays pinned to the top
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
                      color: Theme.of(context).colorScheme.background,
                      child: Html(
                        data: item.prayer.content,
                        style: {
                          'p': Style(
                              fontSize: FontSize(18.sp),
                              fontFamily: "Georgian"),
                        },
                      ),
                    ),
                  );
                },
                childCount: 1, // Number of news articles
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AvatarGlow(
                  animate: isSpeaking,
                  glowColor: const Color.fromARGB(255, 35, 88, 142),
                  child: Material(
                    elevation: 10,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      radius: 20.sp,
                      backgroundColor: Color.fromARGB(255, 17, 10, 115),
                      child: Icon(Icons.mic_none_outlined,
                          color: Colors.white, size: 25.sp),
                    ),
                  ),
                  endRadius: 50.sp),
              InkWell(
                onTap: () async {
                  await flutterTts.setSpeechRate(0.4);
                  await flutterTts.setPitch(0.7);
                  // final languages = await flutterTts.getLanguages;
                  //  if (AppConstant.languages[index].languageCode ==
                  //                 "es") {
                  if (_languageController.selectedIndex == 0) {
                    await flutterTts.setLanguage("en-GB");
                    await flutterTts
                        .setVoice({"name": "Karen", "locale": "en-AU"});
                  } else if (_languageController.selectedIndex == 1) {
                    await flutterTts.setLanguage("es-ES");

                    await flutterTts
                        .setVoice({"name": "Mónica", "locale": "es-ES"});
                  }

                  if (isSpeaking) {
                    flutterTts.pause();
                    setState(() {
                      isSpeaking = false;
                    });
                  } else {
                    flutterTts
                        .speak(removeHtmlTags(item.prayer.content.toString()));
                    setState(() {
                      isSpeaking = true;
                    });
                  }
                },
                child: Icon(
                  isSpeaking ? Icons.pause_circle : Icons.play_circle,
                  size: 50.sp,
                ),
              ),
            ],
          ),
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
