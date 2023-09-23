import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rosary/data/repository/bugFeedback_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';

import '../data/repository/feed_repo.dart';
import '../data/repository/user_repo.dart';
import '../model/feed_model.dart';
import '../model/file_model.dart';
import '../model/response_model.dart';
import '../model/user_model.dart';
import '../utils/constants.dart';
import 'auth_controller.dart';

class BugFeedbackController extends GetxController implements GetxService {
  final BugFeedbackRepo bugFeedbackRepo;
  final SharedPreferences sharedPreferences;
  BugFeedbackController(
      {required this.bugFeedbackRepo, required this.sharedPreferences});

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<ResponseModel> submit(
      String title, String desc, String category) async {
    try {
      _isLoaded = false;
      update();
      Response response =
          await bugFeedbackRepo.postFeedback(title, desc, category);

      if (response.statusCode == 200) {
        print(response.body);

        _isLoaded = true;

        update();
        return ResponseModel(true, "OK");
      } else {
        _isLoaded = true;
        update();
        return ResponseModel(false, "OK");
      }
    } catch (err) {
      _isLoaded = true;
      update();
      return ResponseModel(false, "OK");
    }
  }
}
