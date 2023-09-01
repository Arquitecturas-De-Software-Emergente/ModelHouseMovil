import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:model_house/Security/Interfaces/Account.dart';
import 'package:model_house/Shared/HttpComon.dart';

class HttpAccount {
  var account = http.Client();

  Future<Account?> getAccountByUserId(int userId) async {
    final String accountUrl = "$httpBase/user/$userId/account";
    var uri = Uri.parse(accountUrl);
    var response = await account.get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json"
    });
    print(response.body);
    if (response.statusCode == 200) {
      return Account.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<Account?> postAccountByUserId(int userId, Account data) async {
    final String accountUrl = "$httpBase/user/$userId/account";
    var uri = Uri.parse(accountUrl);
    var response = await account.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json"
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      return Account.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<Account?> getAccountById(int id) async {
    final String accountUrl = "$httpBase/account/$id";
    var uri = Uri.parse(accountUrl);
    var response = await account.get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json"
    });
    if (response.statusCode == 200) {
      return Account.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}
