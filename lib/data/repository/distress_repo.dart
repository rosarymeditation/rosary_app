import 'dart:convert';

import 'package:get/get.dart';
import 'package:rosary/model/distress_model.dart';
import 'package:rosary/model/online_prayer_model.dart';
import 'package:rosary/model/prayer_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';

class DistressRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  DistressRepo({required this.apiClient, required this.sharedPreferences});
  List<String> distressString = [];

  Future<Response> getAll(int page, int limit, int code) async {
    return await apiClient.postData(AppConstant.ALL_DISTRESS_URL,
        {"page": page, "limit": limit, "code": code});
  }

  void saveDistressAsString(List<DistressModel> data) {
    distressString = [];
    data.forEach((element) {
      return distressString.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(
        AppConstant.DISTRESS_LIST_CACHE, distressString);

    //print(sharedPreferences.getStringList(AppConstants.POPULAR_COURSE_DATA));
  }

  List<DistressModel> distressCacheList() {
    List<String> distressString = [];
    List<DistressModel> distressList = [];
    if (sharedPreferences.containsKey(AppConstant.DISTRESS_LIST_CACHE)) {
      distressString =
          sharedPreferences.getStringList(AppConstant.DISTRESS_LIST_CACHE)!;
    }

    for (var element in distressString) {
      distressList.add(DistressModel.fromJson(jsonDecode(element)));
    }
    return distressList;
  }
}
