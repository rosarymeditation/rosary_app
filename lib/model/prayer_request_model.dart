class PrayerRequestModel {
  int? id;
  String? content;
  bool? isChecked;

  PrayerRequestModel(
      {required this.id, required this.content, this.isChecked = true});

  PrayerRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isChecked = json['isChecked'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isChecked'] = this.isChecked;
    data['content'] = this.content;

    return data;
  }
}
