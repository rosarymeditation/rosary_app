class DailyReadingModel {
  String? id;
  String? type;
  String? content;
  String? summary;
  String? date;
  String? language;

  DailyReadingModel({
    this.id,
    this.type,
    this.content,
    this.summary,
    this.date,
    this.language,
  });

  DailyReadingModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    type = json['type'];
    content = json['content'];
    summary = json['summary'];
    date = json['date'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['type'] = this.type;
    data['content'] = this.content;
    data['summary'] = this.summary;
    data['date'] = this.date;
    data['language'] = this.language;

    return data;
  }
}
