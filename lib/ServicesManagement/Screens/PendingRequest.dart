import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';

import '../../Shared/Components/request_card.dart';
import '../../Shared/Widgets/texts/titles.dart';
import '../Interfaces/RequestInterface.dart';
import '../Services/Request_Service.dart';

class PendingRequest extends StatefulWidget {
  List<RequestInterface>? requests;
  UserProfile? userProfile;
  BusinessProfile? businessProfile;
  PendingRequest(this.requests, this.userProfile, this.businessProfile,
      {Key? key})
      : super(key: key);

  @override
  _PendingRequestState createState() => _PendingRequestState();
}

class _PendingRequestState extends State<PendingRequest> {
  RequestInterface? request;
  HttpRequest? httpRequest;
  List<RequestInterface>? requestsPending;
  @override
  void initState() {
    httpRequest = HttpRequest();
    print(widget.requests?.length);
    print('requests: ${widget.requests}');
    print('userProfile: ${widget.userProfile}');
    print('businessProfile: ${widget.businessProfile}');
    super.initState();
  }

  Future changeStatus(RequestInterface requestInterface, String status) async {
    request = await httpRequest?.changeStatus(requestInterface.id!, status);
    if (request != null) {
      requestsPending = await httpRequest?.getAllUserProfileIdAndStatus(
          widget.userProfile!.id!, "Aprobado");
      setState(() {
        request = request;
        widget.requests = requestsPending;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Titles(28, "Your Requests"),
        backgroundColor: const Color(0xffffffff),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0XFF02AA8B),
          ),
          onPressed: () => {Navigator.of(context).pop()},
        ),
      ),
      body: Column(
        children: [
          Container(),
          Expanded(
            child: ListView.builder(
              itemCount: widget.requests?.length, // Número de elementos en la lista
              itemBuilder: (context, index) {
                return RequestCard(
                    '${widget.requests![index].name}',
                    '${widget.requests![index].description}',
                    Container(),
                    Container());
              },
            ),
          ),
        ],
      ),
    );
  }
}
