import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Shared/HttpComon.dart';
import '../Interfaces/ProjectInterface.dart';
import '../Interfaces/Rating.dart';

class HttpProject {
  var project = http.Client();
  Future<List<ProjectInterface>?> getAllProjects() async {
    final persistence = await SharedPreferences.getInstance();
    var uri = Uri.parse("$httpBaseSecurity/project");
    var response = await project.get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      'Authorization': 'Bearer ${persistence.getString("token")}'
    });
    print("PROYECTOS: ${response.body}");
    if (response.statusCode == 200) {
      return projectFromJson(response.body);
    }
    return null;
  }

  Future<ProjectInterface?> updateProject(
      int projectId,
      String title,
      String description,
      List<Map<String, dynamic>> projectActivityDtos,
      List<Map<String, dynamic>> projectResourceDtos,
      ) async {
    final persitence = await SharedPreferences.getInstance();
    var uri = Uri.parse("$httpBaseSecurity/project/${projectId}");
    var response = await project.put(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          'Authorization': 'Bearer ${persitence.getString("token")}'
        },
        body: jsonEncode({
          "title": title,
          "description": description,
          "projectActivityDtos": projectActivityDtos,
          "projectResourceDtos": projectResourceDtos,
        }));
    print("UPDATE PROJECT: ${response.body}");
    if (response.statusCode == 200) {
      return ProjectInterface.fromJson(jsonDecode(response.body));
    }
    return null;
  }
  Future<bool?> uploadFile(File file, int projectId) async {
    print("IMAGE IMAGE");
    var request = http.MultipartRequest('POST',
        Uri.parse('$httpBaseSecurity/project/upload/$projectId'));
    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    var response = await request.send();
    print(response);
    print("IMAGE IMAGE");
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  Future<ProjectInterface?> finishProject(
      int projectId,
      String status
      ) async {
    final persitence = await SharedPreferences.getInstance();
    var uri = Uri.parse("$httpBaseSecurity/project/${projectId}/status/${status}");
    var response = await project.put(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          'Authorization': 'Bearer ${persitence.getString("token")}'
        },
        body: jsonEncode({

        }));
    print("FINISH PROJECT: ${response.body}");
    if (response.statusCode == 200) {
      return ProjectInterface.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<Rating?> getRating(int? projectId) async {
    final persitence = await SharedPreferences.getInstance();
    var uri = Uri.parse("$httpBaseServiceManagement/review/${projectId}");
    var response = await project.get(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          'Authorization': 'Bearer ${persitence.getString("token")}'
        },);

    print("GET RATING: ${response.body}");
    if (response.statusCode == 200) {
      return ratingFromJson(response.body)[0];
    }
    return null;
  }


  Future<Rating?> createRating(
      int projectId,
      int userProfileId,
      double score,
      String comment
      ) async {
    final persitence = await SharedPreferences.getInstance();
    var uri = Uri.parse("$httpBaseServiceManagement/project/$projectId/user_profile/$userProfileId/review");
    var response = await project.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          'Authorization': 'Bearer ${persitence.getString("token")}'
        },
        body: jsonEncode({
          "score": score,
          "comment": comment
        }));
    print("CREATE RATING: ${response.body}");
    if (response.statusCode == 200) {
      return Rating.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
