import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:model_house/Security/Interfaces/User.dart';
import 'package:model_house/Shared/HttpComon.dart';

class HttpUser {
  var user = http.Client();

  Future<User?> signIn(String emailAddress, String password) async {
    final String accountUrl = "$httpBase/user/login";
    var uri = Uri.parse(accountUrl);
    var response = await user.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json"
        },
        body: jsonEncode({
          'emailAddress': emailAddress,
          'password': password,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
    return null;
    //return null;
  }

  Future<User?> signUp(String emailAddress, String password) async {
    final String postUrl = "$httpBase/user/register";
    var uri = Uri.parse(postUrl);
    var response = await user.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json"
        },
        body: jsonEncode({
          'emailAddress': emailAddress,
          'password': password,
        }));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
