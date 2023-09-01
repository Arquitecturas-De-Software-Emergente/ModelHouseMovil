import 'dart:convert';

List<Account> accountFromJson(String str) =>
    List<Account>.from(json.decode(str).map((x) => Account.fromJson(x)));

String accountToJson(List<Account> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Account {
  int id;
  bool isActive;
  int userId;
  Account({
    required this.id,
    required this.isActive,
    required this.userId,
  });
  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"],
        isActive: json["isActive"],
        userId: json["userId"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "isActive": isActive,
        "userId": userId,
      };
}
