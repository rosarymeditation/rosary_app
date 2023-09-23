import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';

import '../data/repository/feed_repo.dart';
import '../model/feed_model.dart';
import '../model/response_model.dart';
import '../utils/constants.dart';

class NetworkController extends GetxController implements GetxService {
  int _connectionStatus = 0;
  int get connectionStatus => _connectionStatus;

  NetworkController();
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e);
    }

    return _updateConnectionStatus(result);
  }

  _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        _connectionStatus = 2;
        print("mobile data");
        break;
      case ConnectivityResult.wifi:
        _connectionStatus = 2;
        print("wifi data");
        break;
      case ConnectivityResult.none:
        _connectionStatus = 1;
        print("none of the above");
        break;
      default:
        Get.snackbar("Network error", "Failed to get network");
        break;
    }
    update();
  }

  @override
  void onClose() {}
}
