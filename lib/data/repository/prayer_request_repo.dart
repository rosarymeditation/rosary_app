import 'dart:convert';

import 'package:get/get.dart';
import 'package:rosary/model/prayer_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';

class PrayerRequestRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  PrayerRequestRepo({required this.apiClient, required this.sharedPreferences});
  List<String> prayerString = [];

  void savePrayerRequestAsString(List<PrayerRequestModel> data) {
    prayerString = [];
    data.forEach((element) {
      return prayerString.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(
        AppConstant.PRAYER_REQUEST_KEY, prayerString);

    //print(sharedPreferences.getStringList(AppConstants.POPULAR_COURSE_DATA));
  }

  List<PrayerRequestModel> prayerRequestCacheList() {
    List<String> prayerRequestString = [];
    List<PrayerRequestModel> prayerList = [];
    if (sharedPreferences.containsKey(AppConstant.PRAYER_REQUEST_KEY)) {
      prayerRequestString =
          sharedPreferences.getStringList(AppConstant.PRAYER_REQUEST_KEY)!;
    } else {
      return [];
    }

    prayerRequestString.forEach((element) {
      print("--e---4-4--4-4-4-4-Loping ---------");
      print(element);
      prayerList.add(PrayerRequestModel.fromJson(jsonDecode(element)));
    });
    return prayerList;
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstant.PRAYER_REQUEST_KEY);

    return true;
  }

  Future<Response> submitRequest(
    String content,
    String? name,
  ) async {
    return await apiClient.postData(AppConstant.SUBMIT_PRAYER_REQUEST_URL,
        {"content": content, "name": name});
  }

  Future<Response> getPrayerRequest(int page, int limit) async {
    return await apiClient.postData(
        AppConstant.ALL_PRAYER_REQUEST_URL, {"page": page, "limit": limit});
  }

  Future<Response> assistPrayer(String prayerId, String randomToken) async {
    return await apiClient.postData(AppConstant.ASSIST_PRAYER_URL,
        {"prayerId": prayerId, "randomToken": randomToken});
  }

  Future<void> setRandomToken(String token) async {
    await sharedPreferences.setString(AppConstant.RANDOM_TOKEN, token);
  }

  Future<String> getRandomToken() async {
    return await sharedPreferences.getString(AppConstant.RANDOM_TOKEN) ?? "";
  }
}
