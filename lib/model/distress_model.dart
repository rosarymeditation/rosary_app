import 'prayer_model.dart';

class Distress {
  late List<DistressModel> _distresses;
  List<DistressModel> get distresses => _distresses;
  Distress({
    required distresses,
  }) {
    this._distresses = distresses;
  }

  Distress.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _distresses = <DistressModel>[];
      json['data'].forEach((v) {
        _distresses.add(new DistressModel.fromJson(v));
      });
    }
  }
}

class DistressModel {
  String? id;
  String? content;
  String? title;
  String? url;

  DistressModel({this.id, this.content, this.title, this.url});

  DistressModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    content = json['content'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = id;
    data['content'] = content;
    data['title'] = title;
    data['url'] = url;

    return data;
  }
}
