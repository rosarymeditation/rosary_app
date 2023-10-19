import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:rosary/songs/play_list.dart';
import 'package:rosary/songs/song_engine.dart';
import 'package:rosary/utils/constants.dart';

class DeepSleepScreen extends StatefulWidget {
  DeepSleepScreen({super.key});

  @override
  State<DeepSleepScreen> createState() => _DeepSleepScreenState();
}

class _DeepSleepScreenState extends State<DeepSleepScreen> {
  //ConnectivityResult _connectivityResult = ConnectivityResult.none;

  @override
  Widget build(BuildContext context) {
    return AudioEngine(
      audioSource: AudioPlaylist.deepSleepSource,
      audioList: [],
      isForRosary: false,
      title: "deep_sleep_music",
      screenName: AppConstant.SCREEN_SLEEP_MUSIC,
    );
  }
}
