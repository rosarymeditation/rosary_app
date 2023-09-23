class DataModel {
  int? id;
  String? type;
  String? name;
  String? title;
  String? scripture;
  String? banner;
  String? text;
  String? reflection;

  DataModel(
      {this.id,
      this.type,
      this.name,
      this.banner,
      this.title,
      this.scripture,
      this.text,
      this.reflection});

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    banner = json['banner'];
    title = json['title'];
    scripture = json['scripture'];
    text = json['text'];
    reflection = json['reflection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['title'] = this.title;
    data['banner'] = this.banner;
    data['name'] = this.name;
    data['scripture'] = this.scripture;
    data['text'] = this.text;
    data['reflection'] = this.reflection;
    return data;
  }
}
