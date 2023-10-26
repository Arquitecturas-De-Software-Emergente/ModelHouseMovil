import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Shared/HttpComon.dart';
import '../Interfaces/RequestInterface.dart';

class HttpRequest {
  var request = http.Client();

  Future<List<RequestInterface>?> getAllBusinessProfileIdAndStatus(
      int businessProfileId, String status) async {
    final persitence = await SharedPreferences.getInstance();
    var uri = Uri.parse(
        "$httpBaseServiceManagement/businessProfile/$businessProfileId/status/$status/request");
    var response = await request.get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      'Authorization': 'Bearer ${persitence.getString("token")}'
    });
    print("getAllBusinessProfileIdAndStatus(): ${response.body}");
    if (response.statusCode == 200) {
      var json = response.body;
      return requestFromJson(json);
    }
    return null;
  }

  Future<List<RequestInterface>?> getAllUserProfileIdAndStatus(
      int userProfileId, String status) async {
    final persitence = await SharedPreferences.getInstance();
    var uri = Uri.parse(
        "$httpBaseServiceManagement/userProfile/$userProfileId/status/$status/request");
    var response = await request.get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      'Authorization': 'Bearer ${persitence.getString("token")}'
    });
    print("INGRESO: ${response.body}");
    if (response.statusCode == 200) {
      var json = response.body;
      return requestFromJson(json);
    }
    return null;
  }

  Future<RequestInterface?> createRequest(
      String userId,
      int businessId,
      String category,
      String estimatedBudget,
      int area,
      String location,
      String description) async {
    final persitence = await SharedPreferences.getInstance();
    var uri = Uri.parse(
        "$httpBaseServiceManagement/userProfile/$userId/businessProfile/$businessId/request");

    var response = await request.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          'Authorization': 'Bearer ${persitence.getString("token")}'
        },
        body: jsonEncode({
          'category': category,
          'estimatedBudget': estimatedBudget,
          'area': area,
          'location': location,
          'description': description,
        }));
    if (response.statusCode == 200) {
      return RequestInterface.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<RequestInterface?> changeStatus(int id, String status) async {
    final persitence = await SharedPreferences.getInstance();
    final String postUrl = "$httpBaseServiceManagement/request/$id";
    var uri = Uri.parse(postUrl);

    var response = await request.put(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          'Authorization': 'Bearer ${persitence.getString("token")}'
        },
        body: jsonEncode({'status': status}));
    print(response.body);

    if (response.statusCode == 200) {
      return RequestInterface.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
