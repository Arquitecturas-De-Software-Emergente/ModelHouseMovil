import 'dart:convert';

List<RequestInterface> requestFromJson(String str) =>
    List<RequestInterface>.from(
        json.decode(str).map((x) => RequestInterface.fromJson(x)));

String requestToJson(List<RequestInterface> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RequestInterface {
  int? id;
  String? requestAt;
  String? status;
  String? description;
  String? accepted;
  int? acceptedAt;
  String? updateAt;
  RequestInterface(
      {this.id,
      this.requestAt,
      this.status,
      this.description,
      this.accepted,
      this.acceptedAt,
      this.updateAt});
  factory RequestInterface.fromJson(Map<String, dynamic> json) =>
      RequestInterface(
          id: json["id"],
          requestAt: json["requestAt"],
          status: json["status:"],
          description: json["description"],
          acceptedAt: json["acceptedAt"],
          updateAt: json["updateAt"]);
  Map<String, dynamic> toJson() => {
        "id": id,
        "requestAt": requestAt,
        "status": status,
        "description": description,
        "accepted": accepted,
        "acceptedAt": acceptedAt,
        "updateAt": updateAt,
      };
}
