import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rosary/model/feedLike.dart';
import 'package:rosary/utils/show_custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';

import '../data/repository/feed_repo.dart';
import '../model/feed_model.dart';
import '../model/response_model.dart';
import '../utils/constants.dart';

class FeedController extends GetxController implements GetxService {
  final FeedRepo feedRepo;
  final SharedPreferences sharedPreferences;
  FeedController({required this.feedRepo, required this.sharedPreferences});

  @override
  void onClose() {}
  List<FeedModel> get feedList => _feedList;
  List<FeedModel> _feedList = [];

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  bool _isMoreLoaded = false;
  bool get isMoreLoaded => _isMoreLoaded;

  late FeedModel _editingContent;
  FeedModel get editingContent => _editingContent;

  int _limit = AppConstant.PAGE_LIMIT;
  int get limit => _limit;

  int _page = 1;
  int get page => _page;

  Future<void> getFeedList() async {
    _page = 1;
    _limit = AppConstant.PAGE_LIMIT;
    try {
      _isLoaded = false;
      update();
      Response response = await feedRepo.getAllFeeds(page, limit);

      if (response.statusCode == 200) {
        _feedList = [];
        _feedList.addAll(Feed.fromJson(response.body).feeds);
      }
    } catch (err) {
      print(err);
    } finally {
      _isLoaded = true;
      update();
    }
  }

  Future<void> getUserFeedList() async {
    _page = 1;
    _limit = AppConstant.PAGE_LIMIT;
    try {
      _isLoaded = false;
      update();
      Response response = await feedRepo.getUserFeeds(page, limit);

      if (response.statusCode == 200) {
        print(response.body);
        _feedList = [];
        _feedList.addAll(Feed.fromJson(response.body).feeds);
      }
    } catch (err) {
      print(err);
    } finally {
      _isLoaded = true;
      update();
    }
  }

  void setEditingContent(FeedModel content) {
    _editingContent = content;
  }

  Future<void> loadMore() async {
    var newPage = _page + 1;
    _isMoreLoaded = false;

    try {
      Response response = await feedRepo.getAllFeeds(newPage, _limit);

      if (response.statusCode == 200) {
        _feedList.addAll(Feed.fromJson(response.body).feeds);
        if (_feedList.length > 0) {
          _page = newPage;
        }
      }
    } catch (err) {
      print(err);
    } finally {
      _isMoreLoaded = true;
      update();
    }
  }

  Future<void> loadMoreUserFeed() async {
    var newPage = _page + 1;
    _isMoreLoaded = false;

    try {
      Response response = await feedRepo.getUserFeeds(newPage, _limit);

      if (response.statusCode == 200) {
        _feedList.addAll(Feed.fromJson(response.body).feeds);
        if (_feedList.length > 0) {
          _page = newPage;
        }
      }
    } catch (err) {
      print(err);
    } finally {
      _isMoreLoaded = true;
      update();
    }

    //} else {}
  }

  Future<ResponseModel> uploadWithImage(File imageFile, String content,
      {isForUpdate = false, String id = ""}) async {
    try {
      _isLoaded = false;

      update();
// open a bytestream
      var token = sharedPreferences.containsKey(AppConstant.TOKEN)
          ? sharedPreferences.getString(AppConstant.TOKEN)!
          : "token";
      var stream =
          new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));

// get file length
      var length = await imageFile.length();

// string to uri
      var uri = isForUpdate
          ? Uri.parse(AppConstant.BASE_URL + AppConstant.UPDATE_FEED_URL(id))
          : Uri.parse(AppConstant.BASE_URL + AppConstant.FEED_SAVE);
      var request =
          new http.MultipartRequest(isForUpdate ? "PATCH" : "POST", uri);
      request.headers
          .addAll(<String, String>{'Authorization': 'Bearer $token'});
      request.fields['content'] = content;
      var multipartFile = new http.MultipartFile('photo', stream, length,
          filename: basename(imageFile.path));
      request.files.add(multipartFile);

      var response = await request.send();
      final responseBody = await http.Response.fromStream(response);
      if (responseBody.statusCode == 200) {
        if (isForUpdate) {
          getUserFeedList();
        } else {
          await getFeedList();
        }

        _isLoaded = true;
        update();
        return ResponseModel(true, "OK");
      } else {
        _isLoaded = true;
        update();
        return ResponseModel(false, "ERROR");
      }
    } catch (err) {
      _isLoaded = true;
      update();
      return ResponseModel(false, "ERROR");
    }
  }

  Future<ResponseModel> uploadWithoutImage(String content,
      {isForUpdate = false, String id = ""}) async {
    try {
      _isLoaded = false;
      update();
      Response response = isForUpdate
          ? await feedRepo.updateFeed(id, content)
          : await feedRepo.postFeed(content);

      if (response.statusCode == 200) {
        print(response.body);

        _isLoaded = true;
        if (isForUpdate) {
          getUserFeedList();
        } else {
          await getFeedList();
        }
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

  Future<ResponseModel> like(String feedId, {isForUpdate = false}) async {
    try {
      update();
      Response response = await feedRepo.likeFeed(feedId);

      if (response.statusCode == 200) {
        bool isForDelete = response.body["isForDelete"];
        String userId = response.body["userId"];

        _feedList.forEach(
          (value) {
            if (value.id == feedId) {
              print(userId);
              if (!isForDelete) {
                value.likes!
                    .addNonNull(PostLikeModel(feed: feedId, user: userId));
              } else {
                value.likes!.removeWhere((item) => item.user == userId);
              }
            }
          },
        );
        update();
        return ResponseModel(true, "OK");
      } else {
        update();
        return ResponseModel(false, "OK");
      }
    } catch (err) {
      update();
      return ResponseModel(false, "OK");
    }
  }

  Future<ResponseModel> deleteFeed(String id) async {
    try {
      _isLoaded = false;
      update();
      Response response = await feedRepo.deleteFeed(id);

      if (response.statusCode == 200) {
        print(response.body);
        _feedList.removeWhere((item) => item.id == id);
        _isLoaded = true;
        showCustomSnackBar("Post was deleted successfully",
            isError: false, title: "Deleted");
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
