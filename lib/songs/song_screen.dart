import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:rosary/songs/play_list.dart';
import 'package:rosary/songs/song_engine.dart';
import 'package:rosary/utils/constants.dart';

class SongScreen extends StatefulWidget {
  SongScreen({super.key});

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  //ConnectivityResult _connectivityResult = ConnectivityResult.none;

  @override
  Widget build(BuildContext context) {
    return AudioEngine(
      audioSource: AudioPlaylist.audioSource,
      audioList: AudioPlaylist.songs,
      isForRosary: false,
      title: "songs",
      screenName: AppConstant.SCREEN_SONGS,
    );
  }
}
