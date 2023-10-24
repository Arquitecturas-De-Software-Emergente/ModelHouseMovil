import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:model_house/ServicesManagement/utils/CustomException.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Shared/HttpComon.dart';
import '../Interfaces/Proposal.dart';
import '../utils/ServiceException.dart';

class HttpProposal {
  var proposal = http.Client();

  //Get proposal
  Future<List<Proposal>?> getProposals() async {
    try{
      final persistence = await SharedPreferences.getInstance();
      var uri = Uri.parse("$httpBaseServiceManagement/proposal");
      var response = await proposal.get(uri, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
        'Authorization': 'Bearer ${persistence.getString("token")}'
      });
      var json = response.body;
      return proposalFromJson(json);
    } on CustomException catch(e){
      throw ServiceException(e.message);
    }
  }

  //
  Future<Proposal?> createByRequestId(int requestId, String description,
      int price, String status, bool isResponse) async {
    final persitence = await SharedPreferences.getInstance();
    var uri = Uri.parse("$httpBaseServiceManagement/request/$requestId/proposal");
    var response = await proposal.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          'Authorization': 'Bearer ${persitence.getString("token")}'
        },
        body: jsonEncode({
          'price': price,
          'description': description,
          'status': status,
          'isResponse': isResponse
        }));
    if (response.statusCode == 200) {
      return Proposal.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<Proposal?> updateRequest(
      int id,
      String proposalDate,
      String description,
      int price,
      String status,
      bool isResponse,
      String responseDate) async {
    final persitence = await SharedPreferences.getInstance();
    final String postUrl = "$httpBaseServiceManagement/user_profile/$id";
    var uri = Uri.parse(postUrl);

    var response = await proposal.post(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          'Authorization': 'Bearer ${persitence.getString("token")}'
        },
        body: jsonEncode({
          'proposalDate': proposalDate,
          'description': description,
          'price': price,
          'status': status,
          'isResponse': isResponse,
          'responseDate': responseDate
        }));
    if (response.statusCode == 200) {
      return Proposal.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  //To be Checked
  Future<Proposal?> changeStatus(int id, String status) async {
    final persistence = await SharedPreferences.getInstance();
    //
    final String putUrl = "$httpBaseServiceManagement/request/$id/$status";
    //
    var uri = Uri.parse(putUrl);
    var response = await proposal.put(uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          'Authorization': 'Bearer ${persistence.getString("token")}'
        },
        body: jsonEncode({'status': status}));
    if (response.statusCode == 200) {
      return Proposal.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<List<Proposal>?> getProposalsByStatus() async {
    try{
      final persistence = await SharedPreferences.getInstance();
      var uri = Uri.parse("$httpBaseServiceManagement/proposal");
      var response = await proposal.get(uri, headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
        'Authorization': 'Bearer ${persistence.getString("token")}'
      });
      var json = response.body;
      return proposalFromJson(json);
    } on CustomException catch(e){
      throw ServiceException(e.message);
    }
  }

}
