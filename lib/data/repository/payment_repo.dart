import 'dart:convert';

import 'package:get/get.dart';
import 'package:rosary/model/prayer_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';

class PaymentRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  PaymentRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> postPayment(
    String amount,
    String currency,
  ) async {
    return await apiClient.postData(AppConstant.PAYMENT_URL, {
      "amount": amount,
      "currency": currency,
    });
  }

  Future<Response> postCurrency() async {
    return await apiClient.postData(AppConstant.CURRENCIES_URL, {});
  }

  Future<Response> postExecutePayment(
      String paymentId, String amount, String currency, String payerId) async {
    return await apiClient.postData(AppConstant.EXECUTE_PAYPAL_URL, {
      "paymentId": paymentId,
      "amount": amount,
      "currency": currency,
      "payerId": payerId
    });
  }

  Future<Response> postSripePayment(String amount) async {
    return await apiClient.postData(AppConstant.STRIPE_PAYMENT_URL, {
      "amount": amount,
    });
  }
}
