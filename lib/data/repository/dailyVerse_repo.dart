import 'dart:convert';

import 'package:get/get.dart';
import 'package:rosary/model/daily_verse_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';

class DailyVerseRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  DailyVerseRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getDailyVerse(body) async {
    return apiClient.postData(AppConstant.TODAYS_VERSE_URL, body);
  }

  void cacheDailyVerse(DailyVerseModel data) {
    sharedPreferences.setString(
      AppConstant.DAILY_VERSE_CACHE,
      jsonEncode(data),
    );
  }

  DailyVerseModel getDailyVerseCache() {
    if (sharedPreferences.containsKey(AppConstant.DAILY_VERSE_CACHE)) {
      var getData = sharedPreferences.getString(AppConstant.DAILY_VERSE_CACHE)!;
      var getMappedData = DailyVerseModel.fromJson(jsonDecode(getData));
      return getMappedData;
    } else {
      return DailyVerseModel(content: "", id: "", verse: "");
    }
  }
}
