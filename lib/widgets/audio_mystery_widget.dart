import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/audio_controller.dart';
import '../controllers/main_controller.dart';
import 'big_text.dart';

class AudioMysteryWidget extends StatelessWidget {
  String text;
  String mystery;
  String days;
  AudioMysteryWidget(
      {super.key,
      required this.text,
      required this.mystery,
      required this.days});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AudioController>(builder: (audio) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: text,
                    size: 19.sp,
                    isBold: true,
                  ),
                  Text(
                    days,
                    style: TextStyle(color: Colors.black38, fontSize: 14.sp),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 25.sp,
                child: IconButton(
                  onPressed: null,
                  iconSize: 30.sp,
                  icon: audio.audioCurrentMystery == mystery
                      ? audio.isPlaying
                          ? Icon(Icons.pause)
                          : Icon(Icons.play_arrow)
                      : Icon(Icons.play_arrow),
                ),
              )
            ],
          )
        ],
      );
    });
  }
}
