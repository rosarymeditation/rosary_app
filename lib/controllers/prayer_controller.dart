import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:rosary/data/repository/prayer_request_repo.dart';
import 'package:rosary/model/comment_model.dart';
import 'package:rosary/model/prayer_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repository/feedComment_repo.dart';
import '../data/repository/feed_repo.dart';
import '../data/repository/prayer_repo.dart';
import '../model/feed_model.dart';
import '../model/online_prayer_model.dart';
import '../model/response_model.dart';
import '../utils/constants.dart';
import 'langauge_controller.dart';

class PrayerController extends GetxController {
  final PrayerRepo prayerRepo;
  PrayerController({required this.prayerRepo});

  var _local = Get.find<LocalizationController>();
  List<OnlinePrayerModel> get catholicPrayerList => _catholicPrayerList;
  List<OnlinePrayerModel> _catholicPrayerList = [];

  List<OnlinePrayerModel> get otherPrayerList => _otherPrayerList;
  List<OnlinePrayerModel> _otherPrayerList = [];

  List<OnlinePrayerModel> get novenaPrayerList => _novenaPrayerList;
  List<OnlinePrayerModel> _novenaPrayerList = [];

  // List<OnlinePrayerModel> get cachedCatholicPrayerList =>
  //     prayerRepo.catholicCacheList();
  // List<OnlinePrayerModel> get cachedOtherPrayerList =>
  //     prayerRepo.othersCacheList();

  OnlinePrayerModel get prayer => _prayer;
  late OnlinePrayerModel _prayer;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  String _prayerType = "type =";
  String get prayerType => _prayerType;

  String _currentFeedId = "";
  String get currentFeedId => _currentFeedId;
  bool _isMoreLoaded = false;
  bool get isMoreLoaded => _isMoreLoaded;

  int _limit = AppConstant.PAGE_LIMIT;
  int get limit => _limit;

  int _page = 1;
  int get page => _page;

  void setPrayerType(String type) {
    _prayerType = type;
  }

  void setPrayer(OnlinePrayerModel prayer) {
    _prayer = prayer;
    update();
  }

  Future<void> getPrayerList() async {
    _isLoaded = false;
    update();
    _page = 1;
    try {
      Response response = await prayerRepo.getAll(_page, _limit, 1);
      print("Body-----------------------------");
      print(response.statusText);
      //print('Sending data: ${jsonEncode(response.bodyBytes)}');
      print("Body-----------------------------");
      if (response.statusCode == 200) {
        _otherPrayerList = [];

        _otherPrayerList.addAll(Prayer.fromJson(response.body).prayers);
        prayerRepo.saveOthersAsString(_otherPrayerList);
      } else {}
      _isLoaded = true;
      update();
    } catch (err) {
      print(err);
      _isLoaded = true;
      update();
      print("yesssjddkdkd");
      print(err);
    }
  }

  Future<void> getCatholicPrayerList(languageCode) async {
    _isLoaded = false;
    update();
    _page = 1;
    try {
      print(languageCode);
      Response response =
          await prayerRepo.getAllCatholic(_page, _limit, languageCode);
      print(response.body);
      if (response.statusCode == 200) {
        _catholicPrayerList = [];

        // print(response.body);

        _catholicPrayerList.addAll(Prayer.fromJson(response.body).prayers);
        prayerRepo.saveCatholicAsString(_catholicPrayerList);
      }
      _isLoaded = true;
      update();
    } catch (err) {
      _isLoaded = true;
      update();
      print("yesssjddkdkd");
      print(err);
    }
  }

  Future<void> getNovenaPrayerList() async {
    _isLoaded = false;
    update();
    _page = 1;
    try {
      Response response =
          await prayerRepo.getAllNovena(_page, _limit, _local.selectedIndex);
      print(response.body);
      if (response.statusCode == 200) {
        // print("returned=======");
        _novenaPrayerList = [];

        // print(response.body);

        _novenaPrayerList.addAll(Prayer.fromJson(response.body).prayers);
        prayerRepo.saveNovenaAsString(_novenaPrayerList);
      }
      _isLoaded = true;
      update();
    } catch (err) {
      _isLoaded = true;
      update();
      print("yesssjddkdkd");
      print(err);
    }
  }

  Future<void> loadMore() async {
    var newPage = _page + 1;
    _isMoreLoaded = false;

    try {
      Response response =
          await prayerRepo.getAll(newPage, _limit, _local.selectedIndex);

      if (response.statusCode == 200) {
        _otherPrayerList.addAll(Prayer.fromJson(response.body).prayers);
        if (_otherPrayerList.length > 0) {
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

  Future<void> loadMoreCatholic() async {
    var newPage = _page + 1;
    _isMoreLoaded = false;

    try {
      Response response = await prayerRepo.getAllCatholic(
          newPage, _limit, _local.selectedIndex);

      if (response.statusCode == 200) {
        _catholicPrayerList.addAll(Prayer.fromJson(response.body).prayers);
        if (_catholicPrayerList.length > 0) {
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
}
