class DailyVerseModel {
  String? id;
  String? content;
  String? verse;
  String? date;

  DailyVerseModel({this.id, this.content, this.verse});

  DailyVerseModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    content = json['content'];
    verse = json['verse'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = id;
    data['content'] = content;
    data['verse'] = verse;

    return data;
  }
}
