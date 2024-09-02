import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  late SharedPreferences sharedPreferences;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    token = sharedPreferences.containsKey(AppConstant.TOKEN)
        ? sharedPreferences.getString(AppConstant.TOKEN)!
        : "token";
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }
  void updateHeader(String token) {
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      Response response = await get(uri, headers: headers ?? _mainHeaders)
          .timeout(Duration(seconds: 10));
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> postData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      Response response = await post(
        uri,
        body,
        headers: headers ?? _mainHeaders,
      );
      return response;
    } catch (e) {
      print("Errorr--------------------");
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> deleteData(String uri,
      {Map<String, String>? headers}) async {
    try {
      Response response = await delete(uri, headers: headers ?? _mainHeaders)
          .timeout(Duration(seconds: 10));
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  Future<Response> updateData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      Response response =
          await patch(uri, body, headers: headers ?? _mainHeaders)
              .timeout(Duration(seconds: 10));
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
