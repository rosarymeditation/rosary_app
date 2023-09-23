import 'comment_model.dart';
import 'user_model.dart';

class Comment {
  late List<CommentsModel> _comments;
  List<CommentsModel> get comments => _comments;
  Comment({
    required comments,
  }) {
    this._comments = comments;
  }

  Comment.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _comments = <CommentsModel>[];
      json['data'].forEach((v) {
        _comments.add(new CommentsModel.fromJson(v));
      });
    }
  }
}

class CommentsModel {
  String? id;
  String? content;
  UserModel? author;
  String? feed;
  String? createdAt;

  CommentsModel({
    this.id,
    this.content,
    this.author,
    this.feed,
    this.createdAt,
  });

  CommentsModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    content = json['content'];
    author =
        json['author'] != null ? new UserModel.fromJson(json['author']) : null;
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
