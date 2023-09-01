import 'dart:convert';

List<ProyectResource> proyectResourceFromJson(String str) =>
    List<ProyectResource>.from(
        json.decode(str).map((x) => ProyectResource.fromJson(x)));

String proyectResourceToJson(List<ProyectResource> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProyectResource {
  int? id;
  String? description;
  String? status;
  String? quantity;
  String? state;
  ProyectResource(
      {this.id, this.description, this.quantity, this.status, this.state});
  factory ProyectResource.fromJson(Map<String, dynamic> json) =>
      ProyectResource(
          id: json["id"],
          description: json["description"],
          quantity: json["quantity"],
          status: json["status"],
          state: json["state"]);
  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "quantity": quantity,
        "status": status,
        "state": state
      };
}
