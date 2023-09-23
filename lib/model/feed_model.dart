import 'package:rosary/model/feedLike.dart';
import 'package:rosary/model/status_model.dart';

import 'comment_model.dart';
import 'user_model.dart';

class Feed {
  late List<FeedModel> _feeds;
  List<FeedModel> get feeds => _feeds;
  Feed({
    required feeds,
  }) {
    this._feeds = feeds;
  }

  Feed.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _feeds = <FeedModel>[];
      json['data'].forEach((v) {
        _feeds.add(new FeedModel.fromJson(v));
      });
    }
  }
}

class FeedModel {
  bool? hasUpdated;
  String? id;
  String? content;
  String? url;
  UserModel? author;
  StatusModel? status;
  List<CommentsMD>? comments;
  List<PostLikeModel>? likes;
  String? createdAt;

  FeedModel({
    this.hasUpdated,
    this.id,
    this.content,
    this.url,
    this.author,
    this.status,
    this.comments,
    this.likes,
    this.createdAt,
  });

  FeedModel.fromJson(Map<String, dynamic> json) {
    hasUpdated = json['hasUpdated'];
    id = json['_id'];
    content = json['content'];
    url = json['url'];
    status = json['status'] != null
        ? new StatusModel.fromJson(json['status'])
        : null;
    author =
        json['author'] != null ? new UserModel.fromJson(json['author']) : null;
    if (json['comments'] != null) {
      comments = <CommentsMD>[];
      json['comments'].forEach((v) {
        comments!.add(new CommentsMD.fromJson(v));
      });
    }
    if (json['likes'] != null) {
      likes = <PostLikeModel>[];
      json['likes'].forEach((v) {
        likes!.add(new PostLikeModel.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasUpdated'] = hasUpdated;
    data['_id'] = id;
    data['content'] = content;
    data['url'] = url;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;

    return data;
  }
}

class CommentsMD {
  String? id;
  String? content;
  String? author;
  String? feed;
  String? createdAt;

  CommentsMD({
    this.id,
    this.content,
    this.author,
    this.feed,
    this.createdAt,
  });

  CommentsMD.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    content = json['content'];
    author = json['author'];
    feed = json['feed'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = id;
    data['content'] = content;
    data['author'] = author;
    data['feed'] = feed;
    data['createdAt'] = createdAt;

    return data;
  }
}
