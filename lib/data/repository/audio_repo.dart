import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';

class AudioRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AudioRepo({required this.apiClient, required this.sharedPreferences});

  Future<bool> setGloriousUrl(String url) async {
    return await sharedPreferences.setString(
        AppConstant.GLORIOUS_AUDIO_URL, url);
  }

  Future<Response> getAllAudios(int page, int limit) async {
    return await apiClient
        .postData(AppConstant.AUDIOS_URL, {"page": page, "limit": limit});
  }

  Future<String> getGloriousUrl() async {
    return await sharedPreferences.getString(AppConstant.GLORIOUS_AUDIO_URL) ??
        "";
  }

  Future<bool> setJoyfulUrl(String url) async {
    return await sharedPreferences.setString(AppConstant.JOYFUL_AUDIO_URL, url);
  }

  Future<String> getJoyfulUrl() async {
    return await sharedPreferences.getString(AppConstant.JOYFUL_AUDIO_URL) ??
        "";
  }

  Future<bool> setSorrowfulUrl(String url) async {
    return await sharedPreferences.setString(
        AppConstant.SORROWFUL_AUDIO_URL, url);
  }

  Future<String> getSorrowfulUrl() async {
    return await sharedPreferences.getString(AppConstant.SORROWFUL_AUDIO_URL) ??
        "";
  }

  Future<bool> setLuminousUrl(String url) async {
    return await sharedPreferences.setString(
        AppConstant.LUMINOUS_AUDIO_URL, url);
  }

  Future<String> getLuminousUrl() async {
    return await sharedPreferences.getString(AppConstant.LUMINOUS_AUDIO_URL) ??
        "";
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstant.JOYFUL_AUDIO_URL);
    sharedPreferences.remove(AppConstant.GLORIOUS_AUDIO_URL);
    sharedPreferences.remove(AppConstant.SORROWFUL_AUDIO_URL);
    sharedPreferences.remove(AppConstant.LUMINOUS_AUDIO_URL);

    return true;
  }
}
