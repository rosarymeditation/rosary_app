import 'prayer_model.dart';

class Psalm {
  late List<PsalmModel> _psalms;
  List<PsalmModel> get psalms => _psalms;
  Psalm({
    required psalms,
  }) {
    this._psalms = psalms;
  }

  Psalm.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _psalms = <PsalmModel>[];
      json['data'].forEach((v) {
        _psalms.add(new PsalmModel.fromJson(v));
      });
    }
  }
}

class PsalmModel {
  String? id;
  String? content;
  String? verse;
  String? title;

  PsalmModel({this.id, this.content, this.title, this.verse});

  PsalmModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    content = json['content'];
    title = json['title'];
    verse = json['verse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = id;
    data['content'] = content;
    data['title'] = title;
    data['verse'] = verse;

    return data;
  }
}
