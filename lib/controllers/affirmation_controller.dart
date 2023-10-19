import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rosary/model/affirmation_model.dart';
import 'package:rosary/model/daily_verse_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';

import '../data/repository/affirmation_repo.dart';
import '../data/repository/dailyVerse_repo.dart';
import '../data/repository/feed_repo.dart';
import '../data/repository/user_repo.dart';
import '../model/feed_model.dart';
import '../model/file_model.dart';
import '../model/response_model.dart';
import '../model/user_model.dart';
import '../utils/constants.dart';
import 'auth_controller.dart';

class AffirmationController extends GetxController implements GetxService {
  final AffirmationRepo dailyAffirmationRepo;
  final SharedPreferences sharedPreferences;
  AffirmationController(
      {required this.dailyAffirmationRepo, required this.sharedPreferences});
  var _authController = Get.find<AuthController>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _hasAffirmation = false;
  bool get hasAffirmation => _hasAffirmation;

  late AffirmationModel _dailyAffirmation;
  AffirmationModel get dailyAffirmationModel => _dailyAffirmation;

  Future<ResponseModel> getDailyAffirmation(languageCode) async {
    DateTime date = DateTime.now();
    var day = date.day;
    var month = date.month;
    var formattedDate = "$day/$month";
    print(formattedDate);

    _isLoading = true;
    Response response = await dailyAffirmationRepo
        .getDailyAffirmation({"date": formattedDate, "code": languageCode});
    late ResponseModel responseModel;
    print(response.body);
    print("affirmation00000");

    if (response.statusCode == 200) {
      _hasAffirmation = true;
      _dailyAffirmation = AffirmationModel.fromJson(response.body);
      dailyAffirmationRepo.cacheDailyAffirmation(_dailyAffirmation);
      responseModel = ResponseModel(true, "OK");
    } else {
      print("affirmation");
      _hasAffirmation = false;
      responseModel = ResponseModel(false, "Error");
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}
