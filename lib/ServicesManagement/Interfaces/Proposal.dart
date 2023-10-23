import 'dart:convert';

List<Proposal> proposalFromJson(String str) =>
    List<Proposal>.from(json.decode(str).map((x) => Proposal.fromJson(x)));

String proposalToJson(List<Proposal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Proposal {
  int? id;
  String? proposalDate;
  String? description;
  String? status;
  String? projectActivities;

  Proposal(
      {this.id,
      this.proposalDate,
      this.description,
      this.status,
        this.projectActivities
      });
  factory Proposal.fromJson(Map<String, dynamic> json) => Proposal(
        id: json["id"],
        proposalDate: json["proposalDate"],
        description: json["description"],
        status: json["status"],
        projectActivities: json["projectActivities"],
  );
  Map<String, dynamic> toJson() => {
        "id": id,
        "proposalDate": proposalDate,
        "description": description,
        "status": status,
        "projectActivities": projectActivities,
      };
}
