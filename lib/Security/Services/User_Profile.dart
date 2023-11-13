import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/Shared/HttpComon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpUserProfile {
  var businessProfile = http.Client();
  Future<UserProfile?> getUserProfileById(int? accountId) async {
    final persitence = await SharedPreferences.getInstance();
    var uri = Uri.parse('$httpBaseSecurity/account/$accountId/user_profile');
    var response = await businessProfile.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${persitence.getString("token")}'
    });
    if (response.statusCode == 200) {
      return UserProfile.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }
    return null;
  }

  Future<bool?> uploadFile(File file, int userProfile) async {
    var request = http.MultipartRequest('POST',
        Uri.parse('$httpBaseSecurity/user_profile/upload/$userProfile'));
    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<UserProfile?> createProfile(int id, String phoneNumber,
      String firstName, String lastName, String gender, String address) async {
    var uri = Uri.parse('$httpBaseSecurity/account/$id/user_profile');
    var response = await businessProfile.post(uri,
        headers: {
          'Content-Type': 'application/json',
          "Accept": "application/json",
        },
        body: jsonEncode({
          'phoneNumber': phoneNumber,
          'firstName': firstName,
          'lastName': lastName,
          'gender': gender,
          'address': address,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      return UserProfile.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<UserProfile?> updateUserProfile(String phoneNumber, String firstName,
      String lastName, String gender, String? address, int id) async {
    var uri = Uri.parse('$httpBaseSecurity/user_profile/$id');
    var response = await businessProfile.put(uri,
        headers: {
          'Content-Type': 'application/json',
          "Accept": "application/json",
        },
        body: jsonEncode({
          'phoneNumber': phoneNumber,
          'firstName': firstName,
          'lastName': lastName,
          'gender': gender,
          'address': address,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      return UserProfile.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
