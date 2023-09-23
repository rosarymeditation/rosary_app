import 'package:rosary/model/feedLike.dart';
import 'package:rosary/model/status_model.dart';

import 'comment_model.dart';
import 'user_model.dart';

class Audio {
  late List<AudioModel> _audios;
  List<AudioModel> get audios => _audios;
  Audio({
    required audios,
  }) {
    this._audios = audios;
  }

  Audio.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _audios = <AudioModel>[];
      json['data'].forEach((v) {
        _audios.add(new AudioModel.fromJson(v));
      });
    }
  }
}

class AudioModel {
  String? id;
  String? title;
  String? subTitle;
  String? url;
  String? thumbnail;

  AudioModel({this.id, this.title, this.url, this.thumbnail, this.subTitle});

  AudioModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    url = json['url'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['_id'] = id;
    data['title'] = title;
    data['url'] = url;
    data['thumbnail'] = thumbnail;

    return data;
  }
}
