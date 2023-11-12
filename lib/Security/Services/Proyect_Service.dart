import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:model_house/ServicesManagement/Interfaces/ProjectInterface.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Shared/HttpComon.dart';
import '../Interfaces/Proyect.dart';

class HttpProyect {
  var proyect = http.Client();

  Future<List<ProjectInterface>?> getAllByBusinessId(int? businessId) async {
    final persitence = await SharedPreferences.getInstance();
    var uri = Uri.parse("$httpBaseSecurity/business_profile/$businessId/project");
    var response = await proyect.get(uri, headers: {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      'Authorization': 'Bearer ${persitence.getString("token")}'
    });
    if (response.statusCode == 200) {
      return projectFromJson(response.body);
    }
    return null;
  }

  Future<Proyect?> createProject(
      int id, String title, String description, String image) async {
    final persitence = await SharedPreferences.getInstance();
    var uri = Uri.parse("$httpBaseSecurity/project/$id/profile");
    var response = await proyect.post(uri,
        headers: {
          'Content-Type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer ${persitence.getString("token")}'
        },
        body: jsonEncode(
            {'title': title, 'description': description, 'image': image}));
    if (response.statusCode == 200) {
      return Proyect.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<Proyect?> updateProyect(
      int id, String status, String name, String description) async {
    final persitence = await SharedPreferences.getInstance();
    final String postUrl = "$httpBaseSecurity/project/$id";
    var uri = Uri.parse(postUrl);

    var response = await proyect.post(uri,
        headers: {
          'Content-Type': 'application/json',
          "Accept": "application/json",
          'Authorization': 'Bearer ${persitence.getString("token")}'
        },
        body: jsonEncode({
          'status': status,
          'isResponse': name,
          'responseDate': description
        }));
    if (response.statusCode == 200) {
      return Proyect.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
