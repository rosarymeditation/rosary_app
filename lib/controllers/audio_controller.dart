import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rosary/data/repository/audio_repo.dart';
import 'package:rosary/model/days_model.dart';
import 'package:rosary/model/mystery_model.dart';
import 'package:rosary/model/prayer_model.dart';
import 'package:rosary/utils/constants.dart';

import '../data/repository/main_repo.dart';
import '../model/audio_model.dart';
import '../model/mystery_content_model.dart';

class AudioController extends GetxController implements GetxService {
  final AudioRepo audioRepo;
  AudioController({required this.audioRepo});

  late AudioPlayer _audioPlayer;
  AudioPlayer get audioPlayer => _audioPlayer;

  List<AudioModel> get audioList => _audioList;
  List<AudioModel> _audioList = [];

  String _audioScreenName = "";
  String get audioScreenName => _audioScreenName;

  String _audioCurrentMystery = "";
  String get audioCurrentMystery => _audioCurrentMystery;

  String _id = "";
  String get id => _id;

  bool _hasLoadedAudio = false;
  bool get hasLoadedAudio => _hasLoadedAudio;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _isMoreLoaded = false;
  bool get isMoreLoaded => _isMoreLoaded;

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  int _limit = AppConstant.PAGE_LIMIT;
  int get limit => _limit;
  int _page = 1;
  int get page => _page;

  @override
  void onInit() {
    super.onInit();
    _audioPlayer = AudioPlayer();
  }

  Future<void> getVideoList() async {
    _page = 1;
    _limit = AppConstant.PAGE_LIMIT;
    try {
      _isLoaded = false;
      update();
      Response response = await audioRepo.getAllAudios(page, limit);

      if (response.statusCode == 200) {
        _audioList = [];
        _audioList.addAll(Audio.fromJson(response.body).audios);
      }
    } catch (err) {
      print(err);
    } finally {
      _isLoaded = true;
      update();
    }
  }

  Future<void> loadMore() async {
    var newPage = _page + 1;
    _isMoreLoaded = false;

    try {
      Response response = await audioRepo.getAllAudios(newPage, _limit);

      if (response.statusCode == 200) {
        _audioList.addAll(Audio.fromJson(response.body).audios);
        if (_audioList.length > 0) {
          _page = newPage;
        }
      }
    } catch (err) {
      print(err);
    } finally {
      _isMoreLoaded = true;
      update();
    }
  }

  void setAudioCurrentMystery(String mystery) {
    _audioCurrentMystery = mystery;
    update();
  }

  void setAudioScreenName(String screenName) {
    _audioScreenName = screenName;
    update();
  }

  void setCurrentNetworkAudio(String id) {
    _id = id;
    update();
  }

  void setHasLoadedAudio() {
    _hasLoadedAudio = true;
    update();
  }

  void setIsPlaying(bool playing) {
    _isPlaying = playing;
    update();
  }

  Future<bool> cacheGloriousUrl(String url) {
    return audioRepo.setGloriousUrl(url);
  }

  Future<String> getGloriousUrl() {
    return audioRepo.getGloriousUrl();
  }

  Future<bool> cacheJoyfulUrl(String url) {
    return audioRepo.setJoyfulUrl(url);
  }

  Future<String> getJoyfulUrl() {
    return audioRepo.getJoyfulUrl();
  }

  Future<bool> cacheSorrowfulUrl(String url) {
    return audioRepo.setSorrowfulUrl(url);
  }

  Future<String> getSorrowfulUrl() {
    return audioRepo.getSorrowfulUrl();
  }

  Future<bool> cacheLuminousUrl(String url) {
    return audioRepo.setLuminousUrl(url);
  }

  Future<String> getLuminousUrl() {
    return audioRepo.getLuminousUrl();
  }

  void reset() {
    audioRepo.clearSharedData();
    //marks the caches as empty for deciding the alert box in the start screen
  }
}
