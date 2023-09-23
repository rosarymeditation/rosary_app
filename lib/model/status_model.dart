class StatusModel {
  String? id;
  String? name;

  StatusModel({
    this.id,
    this.name,
  });

  StatusModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = id;
    data['name'] = name;

    return data;
  }
}
