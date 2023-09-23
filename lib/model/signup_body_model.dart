class SignUpBody {
  String email;
  String password;
  String firstname;
  String lastname;

  SignUpBody(
      {required this.firstname,
      required this.lastname,
      required this.password,
      required this.email});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data["email"] = this.email;
    data["password"] = this.password;
    data["lastname"] = this.lastname;
    data["firstname"] = this.firstname;
    return data;
  }
}
