class TermsModel {
  String? id;
  String? eula;

  TermsModel({this.id, this.eula});

  TermsModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    eula = json['eula'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = id;
    data['eula'] = eula;

    return data;
  }
}
