class UserModel {
  String? id;
  String? firstname;
  String? lastname;
  String? avatar;
  String? banner;
  String? email;
  String? bio;
  String? password;
  String? createdAt;

  UserModel(
      {this.id,
      this.firstname,
      this.lastname,
      this.email,
      this.bio,
      this.password,
      this.avatar,
      this.banner,
      this.createdAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    avatar = json['avatar'];
    banner = json['banner'];
    bio = json['bio'];
    email = json['email'];
    password = json['password'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['avatar'] = avatar;
    data['banner'] = banner;
    data['bio'] = bio;
    data['password'] = password;
    data['createdAt'] = createdAt;

    return data;
  }
}
