import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Shared/HttpComon.dart';
import '../Interfaces/Rating.dart';
import '../Interfaces/RequestInterface.dart';

class HttpReview {
  var review = http.Client();

  Future<Rating?> getReviewId(
      int projectId) async {
    var uri = Uri.parse(
        "$httpBaseServiceManagement/review/$projectId");
    var response = await review.get(uri, headers: {
      'Content-Type': 'application/json',
      "Accept": "application/json",
    });
    print("getReviewId(): ${response.body}");
    if (response.statusCode == 200) {
      var json = response.body;
      return Rating.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    }
    return null;
  }
}
