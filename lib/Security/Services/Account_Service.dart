import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:model_house/Security/Interfaces/Account.dart';
import 'package:model_house/Shared/HttpComon.dart';

class HttpAccount {
  var account = http.Client();

  Future<Account?> signIn(String emailAddress, String password) async {
    final String accountUrl = "$httpBaseSecurity/login";
    var uri = Uri.parse(accountUrl);
    var response = await account.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json"
        },
        body: jsonEncode({
          'emailAddress': emailAddress,
          'password': password,
        }));
    if (response.statusCode == 200) {
      return Account.fromJson(jsonDecode(response.body));
    }
    return null;
    //return null;
  }

  Future<Account?> signUp(String emailAddress, String password) async {
    final String postUrl = "$httpBaseSecurity/register";
    var uri = Uri.parse(postUrl);
    var response = await account.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json"
        },
        body: jsonEncode({
          'emailAddress': emailAddress,
          'password': password,
        }));
    if (response.statusCode == 200) {
      return Account.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
