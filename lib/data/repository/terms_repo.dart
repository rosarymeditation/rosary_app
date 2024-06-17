import 'dart:convert';

import 'package:get/get.dart';
import 'package:rosary/model/affirmation_model.dart';
import 'package:rosary/model/daily_verse_model.dart';
import 'package:rosary/model/terms_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';

class TermsRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  TermsRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getTerms(String code) async {
    return apiClient.postData(AppConstant.TERMS_URL, {"code": code});
  }

  void cacheTerms(TermsModel data) {
    sharedPreferences.setString(AppConstant.TERMS_CACHE, jsonEncode(data));
  }

  TermsModel getTermsCache() {
    if (sharedPreferences.containsKey(AppConstant.TERMS_CACHE)) {
      var getData = sharedPreferences.getString(AppConstant.TERMS_CACHE)!;
      var getMappedData = TermsModel.fromJson(jsonDecode(getData));
      return getMappedData;
    } else {
      return TermsModel(
        eula: "",
        id: "",
      );
    }
  }
}
