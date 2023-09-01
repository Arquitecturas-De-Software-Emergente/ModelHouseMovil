import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Shared/HttpComon.dart';
import '../Interfaces/ProyectResource.dart';

class HttpProyectResource {
  var proyectResource = http.Client();

  Future<List<ProyectResource>?> getAllByProposalId(Long proposalId) async {
    final persitence = await SharedPreferences.getInstance();
    var uri = Uri.parse("$httpBase/proposal/$proposalId/project_activity");
    var response = await proyectResource.get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      'Authorization': 'Bearer ${persitence.getString("token")}'
    });
    if (response.statusCode == 200) {
      return proyectResourceFromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<ProyectResource?> createProyectResource(
      int proposalId, String description, int quantity, String state) async {
    final persitence = await SharedPreferences.getInstance();
    var uri = Uri.parse("$httpBase/proposal/$proposalId/project_activity");
    var response = await proyectResource.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          'Authorization': 'Bearer ${persitence.getString("token")}'
        },
        body: jsonEncode({
          'description': description,
          'quantity': quantity,
          'state': state
        }));
    if (response.statusCode == 200) {
      return ProyectResource.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<ProyectResource?> updateProyectResource(
      int id, String description, int quantity, String state) async {
    final persitence = await SharedPreferences.getInstance();
    final String postUrl = "$httpBase/project_activity/$id";
    var uri = Uri.parse(postUrl);

    var response = await proyectResource.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          'Authorization': 'Bearer ${persitence.getString("token")}'
        },
        body: jsonEncode({
          'description': description,
          'quantity': quantity,
          'state': state
        }));
    if (response.statusCode == 200) {
      return ProyectResource.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
