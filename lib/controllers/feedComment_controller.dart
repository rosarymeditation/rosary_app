import 'dart:math';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:rosary/data/repository/prayer_request_repo.dart';
import 'package:rosary/model/comment_model.dart';
import 'package:rosary/model/prayer_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repository/feedComment_repo.dart';
import '../data/repository/feed_repo.dart';
import '../model/feed_model.dart';
import '../model/response_model.dart';
import '../utils/constants.dart';

class FeedCommentController extends GetxController {
  final FeedCommentRepo feedCommentRepo;
  FeedCommentController({required this.feedCommentRepo});

  List<CommentsModel> get commentList => _commentList;
  List<CommentsModel> _commentList = [];

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  String _currentFeedId = "";
  String get currentFeedId => _currentFeedId;

  String _currentCommentId = "";
  String get currentCommentId => _currentCommentId;

  String _editingContent = "";
  String get editingContent => _editingContent;
  bool _isMoreLoaded = false;
  bool get isMoreLoaded => _isMoreLoaded;

  int _limit = AppConstant.PAGE_LIMIT;
  int get limit => _limit;

  int _page = 1;
  int get page => _page;
  void setFeedId(id) {
    _currentFeedId = id;
  }

  void setCommentId(id) {
    _currentCommentId = id;
  }

  void setEditingContent(String content) {
    _editingContent = content;
  }

  Future<void> getCommentList(String id) async {
    try {
      Response response =
          await feedCommentRepo.getAllCommentByFeeds(id, _page, _limit);

      if (response.statusCode == 200) {
        _commentList = [];
        print(response.body);

        _commentList.addAll(Comment.fromJson(response.body).comments);
      }
      _isLoaded = true;
      update();
    } catch (err) {
      _isLoaded = true;
      update();
      print(err);
    }

    //} else {}
  }

  Future<void> loadMore(String id) async {
    var newPage = _page + 1;
    _isMoreLoaded = false;

    try {
      Response response =
          await feedCommentRepo.getAllCommentByFeeds(id, newPage, _limit);

      if (response.statusCode == 200) {
        _commentList.addAll(Comment.fromJson(response.body).comments);
        if (_commentList.length > 0) {
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

  Future<ResponseModel> postComment(String id, String content) async {
    print("content:  $content");
    print("id:  $id");
    _isLoaded = false;

    Response response = await feedCommentRepo.postComment(id, content);
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      _commentList.add(CommentsModel.fromJson(response.body));
      responseModel = ResponseModel(true, "OK");
    } else {
      responseModel = ResponseModel(false, "Your comment could not be saved");
    }
    _isLoaded = true;
    update();
    return responseModel;
  }

  Future<ResponseModel> updateComment(String id, String content) async {
    update();
    _isLoaded = false;

    Response response =
        await feedCommentRepo.postFeedCommentUpdate(id, content);
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      _commentList.forEach((value) {
        if (value.id == id) {
          value.content = content;
        }
      });

      _isLoaded = true;
      update();
      //  _commentList.add(CommentsModel.fromJson(response.body));
      responseModel = ResponseModel(true, "OK");
    } else {
      _isLoaded = true;
      update();
      responseModel = ResponseModel(false, "Your comment could not be edited");
    }

    return responseModel;
  }

  Future<ResponseModel> deleteComment() async {
    _isLoaded = false;
    update();
    Response response =
        await feedCommentRepo.postFeedCommentDelete(_currentCommentId);
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      getCommentList(_currentFeedId);
      responseModel = ResponseModel(true, "OK");
    } else {
      responseModel = ResponseModel(false, "Your comment could not be deleted");
    }
    _isLoaded = true;
    update();
    return responseModel;
  }
}
