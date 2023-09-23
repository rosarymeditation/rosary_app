import 'prayer_model.dart';

class Prayer {
  late List<OnlinePrayerModel> _prayers;
  List<OnlinePrayerModel> get prayers => _prayers;
  Prayer({
    required prayers,
  }) {
    this._prayers = prayers;
  }

  Prayer.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _prayers = <OnlinePrayerModel>[];
      json['data'].forEach((v) {
        _prayers.add(new OnlinePrayerModel.fromJson(v));
      });
    }
  }
}

class OnlinePrayerModel {
  String? id;
  String? content;
  String? title;
  String? url;

  OnlinePrayerModel({
    this.id,
    this.content,
    this.title,
    this.url,
  });

  OnlinePrayerModel.fromJson(Map<String, dynamic> json) {
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
