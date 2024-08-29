import 'dart:convert';
import 'package:get/get.dart';
import 'package:rosary/model/daily_reading_model.dart';
import 'package:rosary/model/font_size_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';

class DailyReadingRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  DailyReadingRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getDailyReading(body) async {
    return apiClient.postData(AppConstant.DAILY_READING_URL, body);
  }

  // void cacheDailyVerse(DailyVerseModel data) {
  //   sharedPreferences.setString(
  //       AppConstant.DAILY_VERSE_CACHE, jsonEncode(data));
  // }

  // DailyVerseModel getDailyVerseCache() {
  //   if (sharedPreferences.containsKey(AppConstant.DAILY_VERSE_CACHE)) {
  //     var getData = sharedPreferences.getString(AppConstant.DAILY_VERSE_CACHE)!;
  //     var getMappedData = DailyVerseModel.fromJson(jsonDecode(getData));
  //     return getMappedData;
  //   } else {
  //     return DailyVerseModel(content: "", id: "", verse: "");
  //   }
  // }
  void saveFontSizeCache(FontSizeModel data) {
    sharedPreferences.setString(
        AppConstant.FONT_SIZE_READING_CACHE, jsonEncode(data));

    //print(sharedPreferences.getStringList(AppConstants.POPULAR_COURSE_DATA));
  }

  FontSizeModel getFontSizeCache() {
    String fontSizeString = "";
    // List<DistressModel> distressList = [];
    if (sharedPreferences.containsKey(AppConstant.FONT_SIZE_READING_CACHE)) {
      fontSizeString =
          sharedPreferences.getString(AppConstant.FONT_SIZE_READING_CACHE)!;
    } else {
      return FontSizeModel(
          headerOne: "28.0",
          headerTwo: "15.0",
          headerThree: "14.0",
          paragraph: "16.0");
    }

    return FontSizeModel.fromJson(jsonDecode(fontSizeString));
  }

  void saveDailyReadingCache(DailyReadingModel data) {
    sharedPreferences.setString(
        AppConstant.DAILY_READING_CACHE, jsonEncode(data));

    //print(sharedPreferences.getStringList(AppConstants.POPULAR_COURSE_DATA));
  }

  DailyReadingModel getDailyReadingCache() {
    String dailyReadingString = "";
    // List<DistressModel> distressList = [];
    if (sharedPreferences.containsKey(AppConstant.DAILY_READING_CACHE)) {
      dailyReadingString =
          sharedPreferences.getString(AppConstant.DAILY_READING_CACHE)!;
    } else {
      return DailyReadingModel(content: "", summary: "", date: "");
    }

    return DailyReadingModel.fromJson(jsonDecode(dailyReadingString));
  }
}
