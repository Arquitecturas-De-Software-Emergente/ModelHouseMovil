import 'dart:convert';


List<Rating> ratingFromJson(String str) =>
    List<Rating>.from(json.decode(str).map((x) => Rating.fromJson(x)));

String ratingToJson(List<Rating> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rating {
  int? id;
  double? score;
  String? comment;
  Rating(
      {this.id,
        this.score,
        this.comment,
      });
  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    id: json["id"],
    score: json["description"],
    comment: json["status"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "description": score,
    "status": comment,
  };
}
