import 'dart:convert';

List<ProjectInterface> projectFromJson(String str) =>
    List<ProjectInterface>.from(
        json.decode(str).map((x) => ProjectInterface.fromJson(x)));

String projectToJson(List<ProjectInterface> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectInterface {
  int? id;
  String? title;
  String? description;
  String? image;
  int? businessProfileId;
  ProjectInterface(
      {this.id,
        this.title,
        this.description,
        this.image,
        this.businessProfileId,
      }
      );
  factory ProjectInterface.fromJson(Map<String, dynamic> json) =>
      ProjectInterface(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        businessProfileId: json["businessProfileId"],
      );
  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "businessProfileId": businessProfileId,
  };
}
