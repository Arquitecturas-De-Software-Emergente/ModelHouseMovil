import 'dart:convert';

List<ProyectActivity> proyectActivityFromJson(String str) =>
    List<ProyectActivity>.from(
        json.decode(str).map((x) => ProyectActivity.fromJson(x)));

String proyectActivityToJson(List<ProyectActivity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProyectActivity {
  int? id;
  String? name;
  String? description;
  String? status;
  String? startedAt;
  String? completedAt;
  int? completionPercent;
  ProyectActivity(
      {this.id,
      this.name,
      this.description,
      this.startedAt,
      this.status,
      this.completedAt,
      this.completionPercent});
  factory ProyectActivity.fromJson(Map<String, dynamic> json) =>
      ProyectActivity(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        startedAt: json["startedAt"],
        status: json["status"],
        completedAt: json["completedAt"],
        completionPercent: json["completionPercent"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "startedAt": startedAt,
        "status": status,
        "completedAt": completedAt,
        "completionPercent": completionPercent
      };
}
