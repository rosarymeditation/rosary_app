import 'dart:convert';

import 'package:get/get.dart';
import 'package:rosary/model/prayer_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';

class FeedCommentRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  FeedCommentRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getAllCommentByFeeds(String id, int page, int limit) async {
    return await apiClient.postData(AppConstant.COMMENTS_BY_FEED_URL,
        {"id": id, "page": page, "limit": limit});
  }

  Future<Response> postComment(
    String id,
    String content,
  ) async {
    return await apiClient.postData(
        AppConstant.POST_COMMENT_URL, {"content": content, "feedId": id});
  }

  Future<Response> postFeedCommentDelete(
    String commentId,
  ) async {
    return await apiClient
        .postData(AppConstant.FEED_COMMENT_DELETE, {"id": commentId});
  }

  Future<Response> postFeedCommentUpdate(
    String commentId,
    String content,
  ) async {
    return await apiClient.postData(
        AppConstant.FEED_COMMENT_UPDATE, {"content": content, "id": commentId});
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstant.PRAYER_REQUEST_KEY);

    return true;
  }
}
