import 'package:rosary/model/feedLike.dart';
import 'package:rosary/model/status_model.dart';

import 'comment_model.dart';
import 'user_model.dart';

class PublicPrayerRequest {
  late List<PublicPrayerRequestModel> _prayers;
  List<PublicPrayerRequestModel> get prayers => _prayers;
  PublicPrayerRequest({
    required prayers,
  }) {
    this._prayers = prayers;
  }

  PublicPrayerRequest.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _prayers = <PublicPrayerRequestModel>[];
      json['data'].forEach((v) {
        _prayers.add(new PublicPrayerRequestModel.fromJson(v));
      });
    }
  }
}

class PublicPrayerRequestModel {
  bool? hasUpdated;
  String? id;
  String? content;
  List<Counter>? counter;
  String? name;

  String? createdAt;

  PublicPrayerRequestModel({
    this.hasUpdated,
    this.id,
    this.content,
    this.counter,
    this.name,
    this.createdAt,
  });

  PublicPrayerRequestModel.fromJson(Map<String, dynamic> json) {
    hasUpdated = json['hasUpdated'];
    id = json['_id'];
    if (json['counter'] != null) {
      counter = <Counter>[];
      json['counter'].forEach((v) {
        counter!.add(new Counter.fromJson(v));
      });
    }
    content = json['content'];
    name = json['name'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hasUpdated'] = hasUpdated;
    data['_id'] = id;
    data['content'] = content;
    data['name'] = name;

    data['createdAt'] = createdAt;

    return data;
  }
}

class Counter {
  String? id;
  String? randomToken;

  Counter({this.id, this.randomToken});

  Counter.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    randomToken = json['randomToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['randomToken'] = this.randomToken;
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
