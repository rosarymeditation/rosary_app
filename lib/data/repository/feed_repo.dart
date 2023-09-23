import 'dart:convert';

import 'package:get/get.dart';
import 'package:rosary/model/prayer_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';

class FeedRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  FeedRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getAllFeeds(int page, int limit) async {
    return await apiClient
        .postData(AppConstant.ALL_FEED_URL, {"page": page, "limit": limit});
  }

  Future<Response> getUserFeeds(int page, int limit) async {
    return await apiClient
        .postData(AppConstant.GET_USER_FEEDS, {"page": page, "limit": limit});
  }

  Future<Response> deleteFeed(String id) async {
    return await apiClient.deleteData(AppConstant.DELETE_FEED_URL(id));
  }

  Future<Response> postFeed(content) async {
    return await apiClient
        .postData(AppConstant.FEED_SAVE, {"content": content});
  }

  Future<Response> likeFeed(String feedId) async {
    return await apiClient
        .postData(AppConstant.LIKE_FEED_URL, {"feedId": feedId});
  }

  Future<Response> updateFeed(String id, content) async {
    return await apiClient
        .updateData(AppConstant.UPDATE_FEED_URL(id), {"content": content});
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstant.PRAYER_REQUEST_KEY);

    return true;
  }
}
