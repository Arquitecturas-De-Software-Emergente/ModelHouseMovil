import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/Shared/HttpComon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpUserProfile {
  var businessProfile = http.Client();
  Future<UserProfile?> getUserProfileById(int id) async {
    final persitence = await SharedPreferences.getInstance();
    var uri = Uri.parse('$httpBase/user/$id/user_profile');
    var response = await businessProfile.get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${persitence.getString("token")}'
    });
    if (response.statusCode == 200) {
      return UserProfile.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<UserProfile?> createProfile(int id, UserProfile userProfile) async {
    final persitence = await SharedPreferences.getInstance();
    var uri = Uri.parse('$httpBase/user/$id/user_profile');
    print(userProfile);
    var response = await businessProfile.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          'Authorization': 'Bearer ${persitence.getString("token")}'
        },
        body: jsonEncode(userProfile));
    print(response.body);
    if (response.statusCode == 200) {
      return UserProfile.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<UserProfile?> updateUserProfile(
      int id, UserProfile userProfile) async {
    final persitence = await SharedPreferences.getInstance();
    final String postUrl = "$httpBase/user_profile/$id";
    var uri = Uri.parse(postUrl);

    var response = await businessProfile.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          'Authorization': 'Bearer ${persitence.getString("token")}'
        },
        body: jsonEncode(userProfile));
    if (response.statusCode == 200) {
      return UserProfile.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
