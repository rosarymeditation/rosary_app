import 'dart:async';

import 'package:get/get.dart';
import 'package:rosary/model/response_model.dart';

import '../data/repository/auth_repo.dart';
import '../model/signup_body_model.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  @override
  void onInit() {
    super.onInit();
    setCurrentUserId();
  }

  bool _isLoading = false;
  String _returnUrl = "";
  String _passwordCode = "";
  bool get isLoading => _isLoading;
  String get returnUrl => _returnUrl;
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  String _currentUserId = "";
  String get currentUserId => _currentUserId;

  String _email = "";
  String _verificationCode = "";

  String _phone = '';
  String get phone => _phone;

  void setCurrentIndex(index) {
    _currentIndex = index;
    update();
  }

  void setEmail(String email) {
    _email = email;
  }

  void setCode(String code) {
    _verificationCode = code;
  }

  void setCurrentUserId() async {
    _currentUserId = await getUserId();
  }

  void setCurrentUserIdWithParam(String id) async {
    _currentUserId = id;
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      authRepo.saveUserId(response.body["userId"]);
      _currentUserId = response.body["userId"];
      responseModel = ResponseModel(true, response.body["token"]);
    } else if (response.statusCode == 422) {
      var message = response.body["message"];
      responseModel = ResponseModel(false, message);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> deleteUserAccount() async {
    try {
      _isLoading = true;
      update();
      Response response = await authRepo.deleteUserAccount();
      late ResponseModel responseModel;

      if (response.statusCode == 200) {
        responseModel = ResponseModel(true, "OK");
      } else {
        responseModel = ResponseModel(false, "Error");
      }

      return responseModel;
    } catch (err) {
      return ResponseModel(false, "Error");
    } finally {
      _isLoading = false;
      update();
    }
  }

  Future<ResponseModel> login(String password, String email) async {
    _isLoading = true;
    update();
    print("Getting token");
    print(await authRepo.getUserToken().toString());
    Response response = await authRepo.login({
      "email": email,
      "password": password,
    });
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      authRepo.saveUserId(response.body["userId"]);
      _currentUserId = response.body["userId"];

      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> forgotPassword(String email) async {
    _isLoading = true;
    update();

    Response response = await authRepo.forgotPassword(email);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> resetPassword(password) async {
    _isLoading = true;
    update();

    Response response =
        await authRepo.changePassword(_verificationCode, _email, password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> verifyPassword(String code) async {
    _isLoading = true;
    update();

    Response response = await authRepo.verifyPassword(
      code,
      _email,
    );
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      responseModel = ResponseModel(true, "");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  Future<String> getUserId() async {
    return await authRepo.getUserId();
  }
}
