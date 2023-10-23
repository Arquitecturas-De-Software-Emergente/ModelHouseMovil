import 'dart:convert';

List<Account> accountFromJson(String str) =>
    List<Account>.from(json.decode(str).map((x) => Account.fromJson(x)));

String accountToJson(List<Account> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Account {
  int? id;
  String emailAddress;
  String? password;
  bool isActive;
  String? token;
  String? userProfileId;
  String? businessProfileId;
  Account(
      {this.id,
        required this.emailAddress,
        this.password,
        this.businessProfileId,
        this.userProfileId,
        required this.isActive,
        required this.token});
  factory Account.fromJson(Map<String, dynamic> json) => Account(
    id: json["id"],
    emailAddress: json["emailAddress"],
    password: json["password"],
    isActive: json["isActive"],
    token: json["token"],
    businessProfileId: json["businessProfileId"],
    userProfileId: json["userProfileId"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "emailAddress": emailAddress,
    "password": password,
    "isActive": isActive,
    "token": token,
    "businessProfileId": businessProfileId,
    "userProfileId": userProfileId
  };
}
