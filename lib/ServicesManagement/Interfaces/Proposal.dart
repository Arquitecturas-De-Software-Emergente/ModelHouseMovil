import 'dart:convert';

List<Proposal> proposalFromJson(String str) =>
    List<Proposal>.from(json.decode(str).map((x) => Proposal.fromJson(x)));

String proposalToJson(List<Proposal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Proposal {
  int? id;
  String? proposalDate;
  String? description;
  int? price;
  String? status;
  bool? isResponse;
  String? responseDate;
  Proposal(
      {this.id,
      this.proposalDate,
      this.description,
      this.price,
      this.status,
      this.isResponse,
      this.responseDate});
  factory Proposal.fromJson(Map<String, dynamic> json) => Proposal(
        id: json["id"],
        proposalDate: json["proposalDate"],
        description: json["description"],
        price: json["price"],
        status: json["status"],
        isResponse: json["isResponse"],
        responseDate: json["responseDate"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "proposalDate": proposalDate,
        "description": description,
        "price": price,
        "status": status,
        "isResponse": isResponse,
        "responseDate": responseDate
      };
}
