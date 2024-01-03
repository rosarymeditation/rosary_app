import 'package:flutter/material.dart';
import 'package:rosary/utils/constants.dart';
import '../songs/play_list.dart';
import '../songs/song_engine.dart';

class AudioListingScreen extends StatefulWidget {
  AudioListingScreen({super.key});

  @override
  State<AudioListingScreen> createState() => _AudioListingScreenState();
}

class _AudioListingScreenState extends State<AudioListingScreen> {
  @override
  void initState() {
    // setAudio();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AudioEngine(
      audioSource: AudioPlaylist.audioRosarySource,
      audioList: AudioPlaylist.songsRosary,
      isForRosary: true,
      screenName: AppConstant.SCREEN_ROSARY,
    );
  }
}
