import 'dart:convert';

import 'package:model_house/ServicesManagement/Interfaces/Proposal.dart';


List<ProjectInterface> projectFromJson(String str) =>
    List<ProjectInterface>.from(json.decode(str).map((x) => ProjectInterface.fromJson(x)));

String projectToJson(List<ProjectInterface> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectInterface {
  int? id;
  String? description;
  String? status;
  String? firstName;
  String? image;
  String? imageUserProfile;
  String? lastName;
  String? name;
  String? businessDescription;
  String? reviewId;
  Proposal? proposal;
  List<Map<String, dynamic>>? projectActivities;
  List<Map<String, dynamic>>? projectResources;
  String? title;
  ProjectInterface(
      {this.id,
        this.description,
        this.status,
        this.firstName,
        this.image,
        this.imageUserProfile,
        this.lastName,
        this.name,
        this.businessDescription,
        this.proposal,
        this.projectActivities,
        this.projectResources,
        this.title,
        this.reviewId
      });
  factory ProjectInterface.fromJson(Map<String, dynamic> json) => ProjectInterface(
    id: json["id"],
    description: json["description"],
    status: json["status"],
    reviewId: json["reviewId"],
    firstName: json["proposal"]["request"]["userProfile"]["firstName"],
    lastName: json["proposal"]["request"]["userProfile"]["lastName"],
    imageUserProfile: json["proposal"]["request"]["userProfile"]["image"],
    image: json["image"],
    name: json["proposal"]["request"]["businessProfile"]["name"],
    proposal: Proposal.fromJson(Map<String, dynamic>.from(json["proposal"])),
    businessDescription: json["proposal"]["request"]["businessProfile"]["description"],
    projectActivities: List<Map<String, dynamic>>.from(json["proposal"]["projectActivities"]),
    projectResources: List<Map<String, dynamic>>.from(json["proposal"]["projectResources"]),
    title: json["title"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "status": status,
    "firstName": firstName,
    "lastName": lastName,
    "name": name,
    "image": image,
    "businessDescription": businessDescription,
    "proposal": proposal,
    "projectActivities": projectActivities,
    "projectResources": projectResources,
    "title": title,
    "reviewId": reviewId,
    "image": imageUserProfile,
  };
}
