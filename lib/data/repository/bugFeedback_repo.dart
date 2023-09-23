import 'dart:convert';

import 'package:get/get.dart';
import 'package:rosary/model/prayer_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';

class BugFeedbackRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  BugFeedbackRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> postFeedback(
      String title, String desc, String category) async {
    return await apiClient.postData(AppConstant.FEEDBACK_URL,
        {"title": title, "desc": desc, "catgeory": category});
  }
}
