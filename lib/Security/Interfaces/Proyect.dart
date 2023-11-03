import 'dart:convert';

List<Proyect> proyectFromJson(String str) =>
    List<Proyect>.from(json.decode(str).map((x) => Proyect.fromJson(x)));

String proyectToJson(List<Proyect> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Proyect {
  int id;
  String title;
  String description;
  String image;
  String? status;
  int businessProfileId;
  Proyect({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.businessProfileId,
    this.status
  });
  factory Proyect.fromJson(Map<String, dynamic> json) => Proyect(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      image: json["image"],
      status: json["status"],
      businessProfileId: json["businessProfileId"]);
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "status": status,
        "businessProfileId": businessProfileId,
      };
}
