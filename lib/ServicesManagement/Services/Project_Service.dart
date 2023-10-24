import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Shared/HttpComon.dart';
import '../Interfaces/ProjectInterface.dart';

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
}
