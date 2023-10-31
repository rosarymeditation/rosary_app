import 'dart:convert';

import 'package:get/get.dart';
import 'package:rosary/model/online_prayer_model.dart';
import 'package:rosary/model/prayer_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';

class PrayerRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  PrayerRepo({required this.apiClient, required this.sharedPreferences});
  List<String> catholicString = [];
  List<String> othersString = [];
  List<String> novenaString = [];
  Future<Response> getAll(int page, int limit, int code) async {
    return await apiClient.postData(AppConstant.ALL_PRAYERS_URL,
        {"page": page, "limit": limit, "code": code});
  }

  Future<Response> getAllCatholic(int page, int limit, int code) async {
    return await apiClient.postData(AppConstant.ALL_CATHOLIC_PRAYERS_URL,
        {"page": page, "limit": limit, "code": code});
  }

  Future<Response> getAllNovena(int page, int limit, int code) async {
    return await apiClient.postData(AppConstant.ALL_NOVENA_PRAYERS_URL,
        {"page": page, "limit": limit, "code": code});
  }

  void saveCatholicAsString(List<OnlinePrayerModel> data) {
    catholicString = [];
    data.forEach((element) {
      return catholicString.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(
        AppConstant.CATHOLIC_PRAYER_CACHE, catholicString);

    //print(sharedPreferences.getStringList(AppConstants.POPULAR_COURSE_DATA));
  }

  List<OnlinePrayerModel> catholicCacheList() {
    List<String> catholicString = [];
    List<OnlinePrayerModel> catholicPrayerList = [];
    if (sharedPreferences.containsKey(AppConstant.CATHOLIC_PRAYER_CACHE)) {
      catholicString =
          sharedPreferences.getStringList(AppConstant.CATHOLIC_PRAYER_CACHE)!;
    }

    for (var element in catholicString) {
      catholicPrayerList.add(OnlinePrayerModel.fromJson(jsonDecode(element)));
    }
    return catholicPrayerList;
  }

  void saveOthersAsString(List<OnlinePrayerModel> data) {
    othersString = [];
    data.forEach((element) {
      return othersString.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(
        AppConstant.OTHERS_PRAYER_CACHE, othersString);

    //print(sharedPreferences.getStringList(AppConstants.POPULAR_COURSE_DATA));
  }

  List<OnlinePrayerModel> othersCacheList() {
    List<String> othersString = [];
    List<OnlinePrayerModel> othersPrayerList = [];
    if (sharedPreferences.containsKey(AppConstant.OTHERS_PRAYER_CACHE)) {
      othersString =
          sharedPreferences.getStringList(AppConstant.OTHERS_PRAYER_CACHE)!;
    }

    for (var element in othersString) {
      othersPrayerList.add(OnlinePrayerModel.fromJson(jsonDecode(element)));
    }
    return othersPrayerList;
  }

  void saveNovenaAsString(List<OnlinePrayerModel> data) {
    novenaString = [];
    data.forEach((element) {
      return novenaString.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(
        AppConstant.NOVENA_PRAYER_CACHE, novenaString);

    //print(sharedPreferences.getStringList(AppConstants.POPULAR_COURSE_DATA));
  }

  List<OnlinePrayerModel> novenaCacheList() {
    List<String> novenaString = [];
    List<OnlinePrayerModel> novenaPrayerList = [];
    if (sharedPreferences.containsKey(AppConstant.NOVENA_PRAYER_CACHE)) {
      novenaString =
          sharedPreferences.getStringList(AppConstant.NOVENA_PRAYER_CACHE)!;
    }

    for (var element in novenaString) {
      novenaPrayerList.add(OnlinePrayerModel.fromJson(jsonDecode(element)));
    }
    return novenaPrayerList;
  }
}
