import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Shared/HttpComon.dart';
import '../Interfaces/Proyect.dart';

class HttpProyect {
  var proyect = http.Client();

  Future<List<Proyect>?> getAllByBusinessId(int businessId) async {
    final persitence = await SharedPreferences.getInstance();
    var uri = Uri.parse("$httpBase/business_profile/$businessId/project");
    var response = await proyect.get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      'Authorization': 'Bearer ${persitence.getString("token")}'
    });
    if (response.statusCode == 200) {
      return proyectFromJson(response.body);
    }
    return null;
  }

  Future<Proyect?> createProject(
      int id, String title, String description, String image) async {
    final persitence = await SharedPreferences.getInstance();
    var uri = Uri.parse("$httpBase/project/$id/profile");
    var response = await proyect.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
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
    final String postUrl = "$httpBase/project/$id";
    var uri = Uri.parse(postUrl);

    var response = await proyect.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
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
