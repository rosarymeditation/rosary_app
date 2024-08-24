import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rosary/model/audio_model_cache.dart';
import 'package:rosary/widgets/main_text.dart';

import '../controllers/audio_controller.dart';
import '../controllers/main_controller.dart';
import '../utils/appColor.dart';
import 'big_text.dart';

class AudioWidget extends StatelessWidget {
  String id;
  String title;
  String subTitle;
  bool isForRosary;
  final AudioPlayer audioPlayer;
  var _audioController = Get.find<AudioController>();
  AudioWidget({
    super.key,
    required this.id,
    required this.title,
    this.isForRosary = false,
    this.subTitle = "",
    required this.audioPlayer,
  });

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
                  MainText(
                    color: AppColor.subTitle,
                    text: title,
                    size: 19.sp,
                    isBold: true,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  MainText(
                    color: AppColor.subTitle,
                    text: subTitle,
                    size: 15.sp,
                  ),
                ],
              ),
              audio.id == id
                  ? StreamBuilder<PlayerState>(
                      stream: audioPlayer.playerStateStream,
                      builder: (context, snapshot) {
                        final playerState = snapshot.data;
                        final processingState = playerState?.processingState;
                        final playing = playerState?.playing;
                        if (!(playing ?? false)) {
                          return CircleAvatar(
                            backgroundColor: Colors.grey.shade500,
                            radius: 25.sp,
                            child: IconButton(
                              onPressed: () async {
                                _audioController.setCurrentNetworkAudio(id);

                                await audioPlayer.play();
                                // await audioPlayer.seek(
                                //   Duration.zero,
                                //   index: int.parse(id),
                                // );
                              },
                              iconSize: 30.sp,
                              icon: const Icon(
                                //color: Colors.red,
                                Icons.play_arrow,
                              ),
                            ),
                          );
                        } else {
                          return CircleAvatar(
                            backgroundColor: Colors.grey.shade500,
                            radius: 25.sp,
                            child: IconButton(
                              onPressed: () async {
                                await audioPlayer.pause();
                              },
                              iconSize: 30.sp,
                              icon: Icon(Icons.pause),
                            ),
                          );
                        }
                      })
                  : CircleAvatar(
                      backgroundColor: Colors.grey.shade500,
                      radius: 25.sp,
                      child: IconButton(
                        onPressed: () async {
                          _audioController.setCurrentNetworkAudio(id);
                          await audioPlayer.seek(
                            Duration.zero,
                            index: int.parse(id),
                          );
                          await audioPlayer.play();
                        },
                        iconSize: 30.sp,
                        icon: Icon(
                          Icons.play_arrow,
                        ),
                      ),
                    ),
            ],
          )
        ],
      );
    });
  }
}
