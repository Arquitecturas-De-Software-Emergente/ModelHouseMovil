import 'dart:convert';

List<UserProfile> userProfileFromJson(String str) => List<UserProfile>.from(
    json.decode(str).map((x) => UserProfile.fromJson(x)));

String userProfileToJson(List<UserProfile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserProfile {
  int? id;
  String firstName;
  String lastName;
  String gender;
  String phoneNumber;
  String? image;
  String? registrationDate;
  UserProfile(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.gender,
      required this.phoneNumber,
      this.image,
      this.registrationDate});
  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        phoneNumber: json["phoneNumber"],
        image: json["image"],
        registrationDate: json["registrationDate"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "phoneNumber": phoneNumber,
        "image": image,
        "registrationDate": registrationDate,
      };
}
