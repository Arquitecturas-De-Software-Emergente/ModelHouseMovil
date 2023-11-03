import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/Shared/HttpComon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpBusinessProfile {
  var business = http.Client();
  Future<List<BusinessProfile>?> getAllBusinessProfile(String filter) async {
    var uri = Uri.parse("$httpBaseSecurity/business_profile?filter=$filter");
    var response = await business.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return businessProfileFromJson(json);
    }
    return null;
  }

  Future<BusinessProfile?> getbusinessProfileAccountById(int? accountId) async {
    final persitence = await SharedPreferences.getInstance();
    var uri =
        Uri.parse("$httpBaseSecurity/account/$accountId/business_profile");

    var response = await business.get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      'Authorization': 'Bearer ${persitence.getString("token")}'
    });
    if (response.statusCode == 200) {
      return BusinessProfile.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<BusinessProfile?> createProfile(String name, String description,
      String address, String phoneNumber, String webSite, int accountId) async {
    final persitence = await SharedPreferences.getInstance();
    var uri =
        Uri.parse("$httpBaseSecurity/account/$accountId/business_profile");
    var response = await business.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          'Authorization': 'Bearer ${persitence.getString("token")}'
        },
        body: jsonEncode({
          'name': name,
          'description': description,
          'address': address,
          'phoneNumber': phoneNumber,
          'webSite': webSite,
        }));
    if (response.statusCode == 200) {
      return BusinessProfile.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<bool?> uploadFile(File file, int userProfile) async {
    var request = http.MultipartRequest('POST',
        Uri.parse('$httpBaseSecurity/business_profile/upload/$userProfile'));
    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<BusinessProfile?> updateBusinessProfile(
      String name,
      String address,
      String phoneNumber,
      String webSite,
      String description,
      int accountId) async {
    final persitence = await SharedPreferences.getInstance();
    var uri = Uri.parse("$httpBaseSecurity/business_profile/$accountId");
    var response = await business.put(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          'Authorization': 'Bearer ${persitence.getString("token")}'
        },
        body: jsonEncode({
          'name': name,
          'webSite': webSite,
          'phoneNumber': phoneNumber,
          'address': address,
          'description': description,
        }));
    if (response.statusCode == 200) {
      return BusinessProfile.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
