class AffirmationModel {
  String? id;
  String? content;
  String? date;

  AffirmationModel({this.id, this.content});

  AffirmationModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    content = json['content'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = id;
    data['content'] = content;

    return data;
  }
}
