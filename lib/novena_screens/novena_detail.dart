import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:html/parser.dart' show parse;
import '../controllers/langauge_controller.dart';
import '../controllers/prayer_controller.dart';

class NovenaDetailScreen extends StatefulWidget {
  NovenaDetailScreen({super.key});

  @override
  State<NovenaDetailScreen> createState() => _PrayerDetailScreenState();
}

class _PrayerDetailScreenState extends State<NovenaDetailScreen> {
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
        appBar: MainAppBarWidget(text: item.prayer.title ?? ""),
        // backgroundColor: Colors.yellow.shade100,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Html(
                  data: item.prayer.content,
                  style: {
                    'p': Style(
                        fontSize: FontSize(18.sp), fontFamily: "Georgian"),
                  },
                ),
              ],
            ),
          ),
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
                    flutterTts.speak(
                        removeUnwantedTags(item.prayer.content.toString()));
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

  String removeUnwantedTags(String input) {
    return input
        .replaceAll(RegExp(r'<br>'), '') // Remove <br>
        .replaceAll(RegExp(r'<p>'), '')
        .replaceAll(RegExp(r'</p>'), '')
        .replaceAll(RegExp(r'<sup>\d+</sup>'), ''); // Remove <sup>...</sup>
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flutterTts.stop(); // Stop any ongoing speech
  }
}
