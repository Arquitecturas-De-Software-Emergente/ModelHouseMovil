import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/ServicesManagement/Screens/RequestFinished.dart';
import 'package:model_house/Shared/Components/seeDetails.dart';

import '../../Security/Interfaces/BusinessProfile.dart';
import '../../Shared/Components/request_card.dart';
import '../../Shared/Widgets/texts/titles.dart';
import '../Interfaces/RequestInterface.dart';
import '../Services/Request_Service.dart';

// ignore: must_be_immutable
class RequestCanceled extends StatefulWidget {
  List<RequestInterface>? requests;
  UserProfile? userProfile;
  BusinessProfile? businessProfile;
  RequestCanceled(this.requests, this.userProfile, this.businessProfile,
      {Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RequestCanceledState createState() => _RequestCanceledState();
}

class _RequestCanceledState extends State<RequestCanceled> {
  RequestInterface? request;
  HttpRequest? httpRequest;
  List<RequestInterface>? requestsPending;
  @override
  void initState() {
    httpRequest = HttpRequest();
    print("Canceladossss");
    print(widget.requests?.length);
    print(widget.requests);
    print(widget.userProfile);
    print(widget.businessProfile);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Titles(28, "Canceled"),
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
          if (widget.userProfile != null)
            Expanded(
              child: ListView.builder(
                itemCount: widget.requests?.length ?? 0,
                itemBuilder: (context, index) {
                  return RequestCard(
                      '${widget.requests![index].name}',
                      '${widget.requests![index].description}',
                      SeeDetails(widget.requests![index], "${widget.requests![index].name}"),
                      Text("Canceled"));
                },
              ),
            ),
          if (widget.userProfile == null)
            Expanded(
              child: ListView.builder(
                itemCount: widget.requests?.length ?? 0,
                itemBuilder: (context, index) {
                  return RequestCard(
                      '${widget.requests![index].firstName} ${widget.requests![index].lastName}',
                      '${widget.requests![index].description}',
                      SeeDetails(widget.requests![index], "${widget.requests![index].firstName} ${widget.requests![index].lastName}"),
                      Text("Canceled", style: TextStyle(color: Colors.red),)
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}