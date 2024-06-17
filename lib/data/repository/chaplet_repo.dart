import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/signup_body_model.dart';
import '../../utils/constants.dart';
import '../api/api_client.dart';

class ChapletRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ChapletRepo({required this.apiClient, required this.sharedPreferences});

  Future<String> getTemplate() async {
    return await sharedPreferences.getString(AppConstant.TEMPLATE) ?? "";
  }

  Future<bool> saveTemplate(String template) async {
    return await sharedPreferences.setString(AppConstant.TEMPLATE, template);
  }

  Future<bool> setHasSeenSettings() async {
    return await sharedPreferences.setString(
        AppConstant.HAS_SEEN_SETTINGS, "true");
  }

  bool getHasSeenSettings() {
    return sharedPreferences.containsKey(AppConstant.HAS_SEEN_SETTINGS);
  }
}
