import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/ServicesManagement/Screens/Options.dart';
import 'package:model_house/Shared/Components/PrincipalView.dart';
import 'package:model_house/Shared/Components/acceptRejectButtons.dart';

import '../../Security/Interfaces/Account.dart';
import '../../Shared/Components/request_card.dart';
import '../../Shared/Components/seeDetails.dart';
import '../../Shared/DialogModelHouse.dart';
import '../../Shared/Widgets/texts/titles.dart';
import '../Interfaces/RequestInterface.dart';
import '../Services/Request_Service.dart';

class PendingRequest extends StatefulWidget {
  String status;
  UserProfile? userProfile;
  BusinessProfile? businessProfile;
  Account? account;
  PendingRequest(this.status, this.userProfile, this.businessProfile, this.account,
      {Key? key})
      : super(key: key);

  @override
  _PendingRequestState createState() => _PendingRequestState();
}

class _PendingRequestState extends State<PendingRequest> {
  RequestInterface? request;
  HttpRequest? httpRequest;
  List<RequestInterface>? requests;
  @override
  void initState() {
    httpRequest = HttpRequest();
    getRequest();
    super.initState();
  }
  Future getRequest() async{
    if(widget.businessProfile != null){
      requests = await httpRequest?.getAllBusinessProfileIdAndStatus(widget.businessProfile!.id!, widget.status);
    }else{
      requests = await httpRequest?.getAllUserProfileIdAndStatus(widget.userProfile!.id!, widget.status);
    }
    setState(() {
      requests = requests;
    });
  }
  Future changeStatus(int requestId, String status) async {
    request = await httpRequest?.changeStatus(requestId, status);
    if (request != null) {
      if (widget.userProfile != null){
        requests = await httpRequest?.getAllUserProfileIdAndStatus(
          widget.userProfile!.id!, widget.status);
      }
      else{
        requests = await httpRequest?.getAllBusinessProfileIdAndStatus(
        widget.businessProfile!.id!, widget.status);
      }
      setState(() {
        request = request;
        requests = requests;
        showCustomDialog(context, "Felicidades", "Envío de solicitud exitoso", true, PrincipalView(widget.account!, 1));
      });
    }else{
      showCustomDialog(context, "Algo Salió Mal", "Error al enviar su solicitud", false, PrincipalView(widget.account!, 1));
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
          if (widget.userProfile != null)
            Expanded(
              child: ListView.builder(
                itemCount: requests?.length ?? 0,
                itemBuilder: (context, index) {
                  return RequestCard(
                      '${requests![index].name}',
                      '${requests![index].description}',
                      SeeDetails(requests![index], 'Request to ${requests![index].name}'),
                      Container());
                },
              ),
            ),
          if (widget.userProfile == null)
            Expanded(
              child: ListView.builder(
                itemCount: requests?.length ?? 0,
                itemBuilder: (context, index) {
                  return RequestCard(
                      '${requests![index].firstName} ${requests![index].lastName}',
                      '${requests![index].description}',
                      SeeDetails(requests![index], "Request by ${requests![index].firstName} ${requests![index].lastName}"),
                      AcceptRejectButtons(
                        onAcceptPressed: () {
                          changeStatus(requests![index].id!, "Aprobado");
                        },
                        onRejectPressed: () {
                          changeStatus(requests![index].id!, "Cancelado");
                        },
                      ),);
                },
              ),
            ),
        ],
      ),
    );
  }
}
