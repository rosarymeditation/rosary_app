import 'dart:convert';

import 'package:get/get.dart';
import 'package:rosary/model/affirmation_model.dart';
import 'package:rosary/model/daily_verse_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';

class AffirmationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AffirmationRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getDailyAffirmation(body) async {
    return apiClient.postData(AppConstant.TODAYS_AFFIRMATION_URL, body);
  }

  void cacheDailyAffirmation(AffirmationModel data) {
    sharedPreferences.setString(
        AppConstant.AFFIRMATION_CACHE, jsonEncode(data));
  }

  AffirmationModel getAffirmationCache() {
    if (sharedPreferences.containsKey(AppConstant.AFFIRMATION_CACHE)) {
      var getData = sharedPreferences.getString(AppConstant.AFFIRMATION_CACHE)!;
      var getMappedData = AffirmationModel.fromJson(jsonDecode(getData));
      return getMappedData;
    } else {
      return AffirmationModel(
        content: "",
        id: "",
      );
    }
  }
}
