import 'dart:convert';

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
  Proposal(
      {this.id,
      this.description,
      this.status,
        this.firstName,
        this.lastName,
        this.name,
        this.businessDescription,
      });
  factory Proposal.fromJson(Map<String, dynamic> json) => Proposal(
        id: json["id"],
        description: json["description"],
        status: json["status"],
        firstName: json["request"]["userProfile"]["firstName"],
        lastName: json["request"]["userProfile"]["lastName"],
        name: json["request"]["businessProfile"]["name"],
        businessDescription: json["request"]["businessProfile"]["description"],
  );
  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "status": status,
        "firstName": firstName,
        "lastName": lastName,
        "name": name,
        "businessDescription": businessDescription,
      };
}
