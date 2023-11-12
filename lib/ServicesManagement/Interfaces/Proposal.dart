import 'dart:convert';

import 'package:http/http.dart';
import 'package:model_house/ServicesManagement/Interfaces/RequestInterface.dart';


List<Proposal> proposalFromJson(String str) =>
    List<Proposal>.from(json.decode(str).map((x) => Proposal.fromJson(x)));

String proposalToJson(List<Proposal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Proposal {
  int? id;
  String? description;
  String? status;
  String? firstName;
  String? lastName;
  String? name;
  String? businessDescription;
  RequestInterface? request;
  List<Map<String, dynamic>>? projectActivities;
  List<Map<String, dynamic>>? projectResources;
  String? title;
  Proposal(
      {this.id,
      this.description,
      this.status,
        this.firstName,
        this.lastName,
        this.name,
        this.businessDescription,
        this.projectActivities,
        this.projectResources,
        this.request,
        this.title,
      });
  factory Proposal.fromJson(Map<String, dynamic> json) => Proposal(
        id: json["id"],
        description: json["description"],
        status: json["status"],
        firstName: json["request"]["userProfile"]["firstName"],
        lastName: json["request"]["userProfile"]["lastName"],
        name: json["request"]["businessProfile"]["name"],
        businessDescription: json["request"]["businessProfile"]["description"],
        request: RequestInterface.fromJson(Map<String, dynamic>.from(json["request"])),
        projectActivities: List<Map<String, dynamic>>.from(json["projectActivities"]),
        projectResources: List<Map<String, dynamic>>.from(json["projectResources"]),
        title: json["title"],
  );
  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "status": status,
        "firstName": firstName,
        "lastName": lastName,
        "name": name,
        "request": request,
        "businessDescription": businessDescription,
        "projectActivities": projectActivities,
        "projectResources": projectResources,
        "title": title,
      };
}
