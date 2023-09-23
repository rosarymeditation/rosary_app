import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';

class MainRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  MainRepo({required this.apiClient, required this.sharedPreferences});

  Future<bool> setIntroCounter(String counter) async {
    return await sharedPreferences.setString(
        AppConstant.INTRO_COUNTER, counter);
  }

  Future<String> getIntroCounter() async {
    return await sharedPreferences.getString(AppConstant.INTRO_COUNTER) ?? "0";
  }

  Future<bool> setCounter(String counter) async {
    return await sharedPreferences.setString(AppConstant.COUNTER, counter);
  }

  Future<String> getCounter() async {
    return await sharedPreferences.getString(AppConstant.COUNTER) ?? "0";
  }

  Future<bool> setCurrentMystery(String counter) async {
    return await sharedPreferences.setString(
        AppConstant.MYSTERY_COUNTER, counter);
  }

  Future<String> getCurrentMystery() async {
    return sharedPreferences.getString(AppConstant.MYSTERY_COUNTER) ?? "0";
  }

  Future<bool> setLastScreenName(String value) async {
    return await sharedPreferences.setString(
        AppConstant.LAST_SCREEN_NAME, value);
  }

  Future<String> getLastScreenName() async {
    return sharedPreferences.getString(AppConstant.LAST_SCREEN_NAME) ?? "";
  }

  Future<bool> setCurrentMysteryName(String value) async {
    return await sharedPreferences.setString(AppConstant.MYSTERY_NAME, value);
  }

  Future<String> getCurrentMysteryName() async {
    return sharedPreferences.getString(AppConstant.MYSTERY_NAME) ?? "";
  }

  Future<bool> setHasCache(boolVal) async {
    return await sharedPreferences.setString(AppConstant.HAS_CACHE, boolVal);
  }

  bool getHasCache() {
    return sharedPreferences.containsKey(AppConstant.HAS_CACHE);
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstant.COUNTER);
    sharedPreferences.remove(AppConstant.INTRO_COUNTER);
    sharedPreferences.remove(AppConstant.MYSTERY_COUNTER);
    sharedPreferences.remove(AppConstant.MYSTERY_NAME);
    sharedPreferences.remove(AppConstant.LAST_SCREEN_NAME);
    sharedPreferences.remove(AppConstant.HAS_CACHE);
    apiClient.token = '';

    return true;
  }
}
