import 'dart:convert';


List<ProjectInterface> projectFromJson(String str) =>
    List<ProjectInterface>.from(json.decode(str).map((x) => ProjectInterface.fromJson(x)));

String projectToJson(List<ProjectInterface> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectInterface {
  int? id;
  String? description;
  String? status;
  String? firstName;
  String? lastName;
  String? name;
  String? businessDescription;
  String? reviewId;
  List<Map<String, dynamic>>? projectActivities;
  List<Map<String, dynamic>>? projectResources;
  String? title;
  ProjectInterface(
      {this.id,
        this.description,
        this.status,
        this.firstName,
        this.lastName,
        this.name,
        this.businessDescription,
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
    name: json["proposal"]["request"]["businessProfile"]["name"],
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
    "businessDescription": businessDescription,
    "projectActivities": projectActivities,
    "projectResources": projectResources,
    "title": title,
    "reviewId": reviewId,
  };
}
