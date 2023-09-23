import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/signup_body_model.dart';
import '../../utils/constants.dart';
import '../api/api_client.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(
        AppConstant.REGISTRATION_URL, signUpBody.toJson());
  }

  // Future<Response> forgotPassword(String email) async {
  //   return await apiClient.postData(
  //       AppConstant.FORGOT_PASSWORD_URI, json.encode({'email': email}));
  // }

  // Future<Response> updatePassword(String code, String password) async {
  //   return await apiClient.postData(AppConstants.UPDATE_PASSWORD_URL,
  //       json.encode({'code': code, 'password': password}));
  // }

  // Future<Response> registerGuest(
  //     String phone, String firstName, lastName) async {
  //   return await apiClient.postData(
  //       AppConstants.GUEST_REGISTRATION_URI,
  //       json.encode(
  //           {'firstName': firstName, 'lastName': lastName, 'phone': phone}));
  // }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstant.TOKEN);
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstant.TOKEN);
    // sharedPreferences.remove(AppConstant.PASSWORD);
    // sharedPreferences.remove(AppConstants.PASSWORD);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }

  Future<String> getUserToken() async {
    return await sharedPreferences.getString(AppConstant.TOKEN) ?? "None";
  }

  Future<Response> deleteUserAccount() async {
    return await apiClient.postData(AppConstant.DELETE_USER_URL, {});
  }

  Future<String> getUserId() async {
    return await sharedPreferences.getString(AppConstant.USER_ID) ?? "";
  }

  Future<Response> login(body) async {
    return await apiClient.postData(AppConstant.LOGIN_URL, body);
  }

  Future<Response> forgotPassword(String email) async {
    return await apiClient
        .postData(AppConstant.FORGOT_PASSWORD_URL, {"email": email});
  }

  Future<Response> changePassword(
      String code, String email, String password) async {
    return await apiClient.postData(AppConstant.CHANGE_PASSWORD_URL,
        {"code": code, "email": email, "password": password});
  }

  Future<Response> verifyPassword(String code, String email) async {
    return await apiClient.postData(
        AppConstant.PASSWORD_VERIFICATION_URL, {"code": code, "email": email});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstant.TOKEN, token);
  }

  Future<void> saveUserId(String userId) async {
    try {
      await sharedPreferences.setString(AppConstant.USER_ID, userId);
    } catch (e) {}
  }
}
