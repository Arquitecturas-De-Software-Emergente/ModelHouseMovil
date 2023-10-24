import 'dart:convert';

List<RequestInterface> requestFromJson(String str) =>
    List<RequestInterface>.from(
        json.decode(str).map((x) => RequestInterface.fromJson(x)));

String requestToJson(List<RequestInterface> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RequestInterface {
  int? id;
  String? status;
  String? description;
  String? name;
  String? category;
  String? estimatedBudget;
  int? area;
  String? location;
  String? file;
  String? businessDescription;
  String? firstName;
  String? lastName;
  RequestInterface({
    this.id,
    this.status,
    this.description,
    this.name,
    this.category,
    this.estimatedBudget,
    this.area,
    this.location,
    this.file,
    this.businessDescription,
    this.firstName,
    this.lastName
  });

  factory RequestInterface.fromJson(Map<String, dynamic> json) => RequestInterface(
    id: json["id"],
    status: json["status"],
    description: json["description"],
    name: json["businessProfile"]["name"],
    category: json["category"],
    estimatedBudget: json["estimatedBudget"],
    area: json["area"],
    location: json["location"],
    file: json["file"],
    businessDescription: json["businessProfile"]["description"],
    firstName: json["userProfile"]["firstName"],
    lastName: json["userProfile"]["lastName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "description": description,
    "name": name,
    "category": category,
    "estimatedBudget": estimatedBudget,
    "area": area,
    "location": location,
    "file": file,
    "businessDescription": businessDescription,
    "firstName": firstName,
    "lastName": lastName,
  };
}