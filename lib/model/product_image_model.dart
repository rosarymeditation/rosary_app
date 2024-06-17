class ProductImages {
  String? id;
  String? url;

  ProductImages({this.id, this.url});

  ProductImages.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['url'] = this.url;

    return data;
  }
}
