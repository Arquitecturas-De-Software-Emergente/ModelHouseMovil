import 'dart:convert';

import 'BusinessProfile.dart';
import 'UserProfile.dart';

List<Account> accountFromJson(String str) =>
    List<Account>.from(json.decode(str).map((x) => Account.fromJson(x)));

String accountToJson(List<Account> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Account {
  int id;
  String emailAddress;
  String? password;
  bool isActive;
  String? token;
  BusinessProfile? businessProfile;
  UserProfile?userProfile;
  Account(
      {required this.id,
        required this.emailAddress,
        this.password,
        this.businessProfile,
        this.userProfile,
        required this.isActive,
        required this.token});
  factory Account.fromJson(Map<String, dynamic> json) => Account(
    id: json["id"],
    emailAddress: json["emailAddress"],
    password: json["password"],
    isActive: json["isActive"],
    token: json["token"],
    businessProfile: json["businessProfile"],
    userProfile: json["userProfile"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "emailAddress": emailAddress,
    "password": password,
    "isActive": isActive,
    "token": token,
    "businessProfile": businessProfile,
    "userProfile": userProfile
  };
}
