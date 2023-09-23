class PostLikeModel {
  String? user;
  String? feed;

  PostLikeModel({
    this.user,
    this.feed,
  });

  PostLikeModel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    feed = json['feed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = user;
    data['feed'] = feed;

    return data;
  }
}
