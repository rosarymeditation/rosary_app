import 'dart:convert';

import 'package:get/get.dart';
import 'package:rosary/model/online_prayer_model.dart';
import 'package:rosary/model/prayer_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/psalm_model.dart';
import '../../utils/constants.dart';
import '../api/api_client.dart';

class PsalmRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  PsalmRepo({required this.apiClient, required this.sharedPreferences});
  List<String> psalmString = [];
  List<String> othersString = [];
  Future<Response> getAll(int page, int limit, int code) async {
    return await apiClient.postData(AppConstant.ALL_PSALMS_URL,
        {"page": page, "limit": limit, "code": code});
  }

  void savePsalmAsString(List<PsalmModel> data) {
    psalmString = [];
    data.forEach((element) {
      return psalmString.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppConstant.PSALM_CACHE, psalmString);

    //print(sharedPreferences.getStringList(AppConstants.POPULAR_COURSE_DATA));
  }

  List<PsalmModel> psalmCacheList() {
    List<String> psalmString = [];
    List<PsalmModel> psalmList = [];
    if (sharedPreferences.containsKey(AppConstant.PSALM_CACHE)) {
      psalmString = sharedPreferences.getStringList(AppConstant.PSALM_CACHE)!;
    }

    for (var element in psalmString) {
      psalmList.add(PsalmModel.fromJson(jsonDecode(element)));
    }
    return psalmList;
  }
}
