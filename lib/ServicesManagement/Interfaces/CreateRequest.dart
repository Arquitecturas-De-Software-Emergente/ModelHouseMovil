import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateRequest {
  String category;
  String estimatedBudget;
  int area;
  String location;
  String file;
  String description;
  String status;

  CreateRequest({
    required this.category,
    required this.estimatedBudget,
    required this.area,
    required this.location,
    required this.file,
    required this.description,
    required this.status,
  });

  factory CreateRequest.fromJson(Map<String, dynamic> json) {
    return CreateRequest(
      category: json['category'],
      estimatedBudget: json['estimatedBudget'],
      area: json['area'],
      location: json['location'],
      file: json['file'],
      description: json['description'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "category": category,
      "estimatedBudget": estimatedBudget,
      "area": area,
      "location": location,
      "file": file,
      "description": description,
      "status": status,
    };
  }
}
