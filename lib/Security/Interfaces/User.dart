import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  int id;
  String emailAddress;
  String? password;
  String role;
  bool isActive;
  String? token;
  User(
      {required this.id,
      required this.emailAddress,
      this.password,
      required this.role,
      required this.isActive,
      required this.token});
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        emailAddress: json["emailAddress"],
        password: json["password"],
        role: json["role"],
        isActive: json["isActive"],
        token: json["token"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "emailAddress": emailAddress,
        "password": password,
        "role": role,
        "isActive": isActive,
        "token": token
      };
}
