import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';

import '../utils/appColor.dart';

class Controls extends StatelessWidget {
  final AudioPlayer audioPlayer;
  Controls({super.key, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            audioPlayer.seek(Duration.zero, index: 1);
          },
          color: AppColor.accentColor,
          iconSize: 60,
          icon: const Icon(Icons.skip_previous_rounded),
        ),
        StreamBuilder<PlayerState>(
            stream: audioPlayer.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;
              if (!(playing ?? false)) {
                return IconButton(
                  iconSize: 80.sp,
                  color: AppColor.accentColor,
                  onPressed: audioPlayer.play,
                  icon: const Icon(Icons.play_arrow_rounded),
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  iconSize: 80.sp,
                  color: AppColor.accentColor,
                  onPressed: audioPlayer.pause,
                  icon: const Icon(Icons.pause_rounded),
                );
              }
              return IconButton(
                iconSize: 80.sp,
                color: AppColor.accentColor,
                onPressed: audioPlayer.play,
                icon: const Icon(Icons.play_arrow_rounded),
              );
            }),
        IconButton(
          onPressed: audioPlayer.seekToPrevious,
          color: AppColor.accentColor,
          iconSize: 60,
          icon: const Icon(Icons.skip_next_rounded),
        ),
      ],
    );
  }
}
