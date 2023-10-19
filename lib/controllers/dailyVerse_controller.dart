import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rosary/model/daily_verse_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';

import '../data/repository/dailyVerse_repo.dart';
import '../data/repository/feed_repo.dart';
import '../data/repository/user_repo.dart';
import '../model/feed_model.dart';
import '../model/file_model.dart';
import '../model/response_model.dart';
import '../model/user_model.dart';
import '../utils/constants.dart';
import 'auth_controller.dart';

class DailyVerseController extends GetxController implements GetxService {
  final DailyVerseRepo dailyVerseRepo;
  final SharedPreferences sharedPreferences;
  DailyVerseController(
      {required this.dailyVerseRepo, required this.sharedPreferences});
  var _authController = Get.find<AuthController>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _hasVerse = false;
  bool get hasVerse => _hasVerse;

  late DailyVerseModel _dailyVerseModel;
  DailyVerseModel get dailyVerseModel => _dailyVerseModel;

  Future<ResponseModel> getDailyVerse(languageCode) async {
    DateTime date = DateTime.now();
    var day = date.day;
    var month = date.month;
    var formattedDate = "$day/$month";
    print(formattedDate);

    _isLoading = true;
    Response response = await dailyVerseRepo
        .getDailyVerse({"date": formattedDate, "code": languageCode});
    late ResponseModel responseModel;
    print(response.body);

    if (response.statusCode == 200) {
      _hasVerse = true;
      _dailyVerseModel = DailyVerseModel.fromJson(response.body);
      dailyVerseRepo.cacheDailyVerse(_dailyVerseModel);
      responseModel = ResponseModel(true, "OK");
    } else {
      print("eooeoeoeooeoe");
      _hasVerse = false;
      responseModel = ResponseModel(false, "Error");
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}
