import 'dart:convert';

List<BusinessProfile> businessProfileFromJson(String str) =>
    List<BusinessProfile>.from(
        json.decode(str).map((x) => BusinessProfile.fromJson(x)));

String businessProfileToJson(List<BusinessProfile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BusinessProfile {
  int? id;
  String address;
  String description;
  String? image;
  String name;
  String phoneNumber;
  String webSite;
  int? accountId;
  String? foundationDate;
  BusinessProfile({
    this.id,
    required this.address,
    required this.description,
    this.image,
    required this.name,
    required this.phoneNumber,
    required this.webSite,
    this.accountId,
    this.foundationDate,
  });
  factory BusinessProfile.fromJson(Map<String, dynamic> json) =>
      BusinessProfile(
        id: json["id"],
        address: json["address"],
        description: json["description"],
        image: json["image"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        webSite: json["webSite"],
        accountId: json["accountId"],
        foundationDate: json["foundationDate"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "description": description,
        "image": image,
        "name": name,
        "phoneNumber": phoneNumber,
        "webSite": webSite,
        "accountId": accountId,
        "foundationDate": foundationDate,
      };
}
