import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rosary/controllers/network_controller.dart';
import 'package:rosary/screens/no_network.dart';
import 'package:rosary/utils/constants.dart';
import 'package:rosary/widgets/big_text.dart';
import 'package:rosary/widgets/audio_mystery_widget.dart';
import 'package:http/http.dart' as http;
import 'package:rosary/widgets/main_app_bar_widget.dart';
import '../controllers/audio_controller.dart';
import '../controllers/langauge_controller.dart';
import '../controllers/main_controller.dart';
import '../songs/play_list.dart';
import '../songs/song_engine.dart';
import '../widgets/loading.dart';

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
