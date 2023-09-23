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
import '../data/repository/user_repo.dart';
import '../model/feed_model.dart';
import '../model/file_model.dart';
import '../model/response_model.dart';
import '../model/user_model.dart';
import '../utils/constants.dart';
import 'auth_controller.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  final SharedPreferences sharedPreferences;
  UserController({required this.userRepo, required this.sharedPreferences});
  var _authController = Get.find<AuthController>();

  String _selectedCityName = "";
  String _selectedCityId = "";
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _hasUserInfo = false;
  bool _hasCity = false;
  bool _hasUpdated = false;
  bool get hasUserInfo => _hasUserInfo;

  List<FileModel> _files = [];

  //Stores another user id when visiting their profile
  String _userProfileId = "";
  String get userProfileId => _userProfileId;

  void setUserProfileId(String id) {
    _userProfileId = id;
  }

  late UserModel _userModel;
  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    _isLoading = true;
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      _hasUserInfo = true;

      _userModel = UserModel.fromJson(response.body);
      _authController.setCurrentUserIdWithParam(_userModel.id!);

      responseModel = ResponseModel(true, "OK");
    } else {
      print("eooeoeoeooeoe");
      _hasUserInfo = false;
      responseModel = ResponseModel(false, "Error");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> getProfileData(String id) async {
    _isLoading = true;
    Response response = await userRepo.getProfileData(id);
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      _hasUserInfo = true;

      _userModel = UserModel.fromJson(response.body);
      print("-------------------------Model------Start-----------");
      print(response.body);
      print("-------------------------Model------Start----------");
      responseModel = ResponseModel(true, "OK");
    } else {
      print("eooeoeoeooeoe");
      _hasUserInfo = false;
      responseModel = ResponseModel(false, "Error");
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> submit(File? bannerFile, File? avatarFile,
      String firstname, lastname, bio, email) async {
    _files = [];
    _isLoading = true;
    update();
    late ResponseModel responseModel;
    try {
      if (bannerFile != null) {
        _files.add(
          FileModel(name: 'banner', file: bannerFile),
        );
      }
      if (avatarFile != null) {
        _files.add(FileModel(name: 'avatar', file: avatarFile!));
      }

      var request = http.MultipartRequest('POST',
          Uri.parse(AppConstant.BASE_URL + AppConstant.UPDATE_USER_PROFILE));

      for (var file in _files) {
        print("kekkekekeke");
        //final imageFile = File(file.file.path);
        // final imageStream = http.ByteStream(imageFile.openRead());
        // final imageLength = await imageFile.length();

        var multipartFile = await http.MultipartFile.fromPath(
            file.name, // field name on the API
            file.file.path);

        request.files.add(multipartFile);
      }

      var token = await sharedPreferences.containsKey(AppConstant.TOKEN)
          ? sharedPreferences.getString(AppConstant.TOKEN)!
          : "token";
      request.headers
          .addAll(<String, String>{'Authorization': 'Bearer $token'});

      request.fields['firstname'] = firstname;
      request.fields['lastname'] = lastname;
      request.fields['bio'] = bio;

      var response = await request.send();
      if (response.statusCode == 200) {
        getUserInfo();
        return responseModel = ResponseModel(true, "Done");
      } else {
        return responseModel = ResponseModel(false, "Not Done");
        // return ResponseModel(false, "ERROR");
      }
    } catch (err) {
      print("peppepep");
      print(err);

      return responseModel = ResponseModel(false, "Not Done");
    } finally {
      _isLoading = false;
      update();
    }
  }
}
