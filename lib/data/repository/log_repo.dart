import 'dart:convert';

import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';

class LogRepo {
  final ApiClient apiClient;

  LogRepo({required this.apiClient});

  Future<Response> logRosary() async {
    return apiClient.postData(AppConstant.LOG_ROSARY_URL, {});
  }

  Future<Response> logInpiration() async {
    return apiClient.postData(AppConstant.LOG_INSPIRATION_URL, {});
  }

  Future<Response> logNovena() async {
    return apiClient.postData(AppConstant.LOG_NOVENA_URL, {});
  }

  Future<Response> logPsalm() async {
    return apiClient.postData(AppConstant.LOG_PSALM_URL, {});
  }

  Future<Response> logMystery() async {
    return apiClient.postData(AppConstant.LOG_MYSTERY_URL, {});
  }
}
