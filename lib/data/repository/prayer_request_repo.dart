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
      print("------------------------Has prayer request");
      prayerRequestString =
          sharedPreferences.getStringList(AppConstant.PRAYER_REQUEST_KEY)!;
    } else {
      print("------------------------Has no request");
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
}
