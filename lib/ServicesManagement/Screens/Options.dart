import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/Account.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/Security/Interfaces/User.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/Security/Services/Account_Service.dart';
import 'package:model_house/Security/Services/Business_Profile.dart';
import 'package:model_house/ServicesManagement/Screens/PendingProposal.dart';
import 'package:model_house/ServicesManagement/Interfaces/RequestInterface.dart';
import 'package:model_house/ServicesManagement/Screens/PendingRequest.dart';
import 'package:model_house/ServicesManagement/Screens/RequestCanceled.dart';
import 'package:model_house/ServicesManagement/Screens/RequestFinished.dart';
import 'package:model_house/ServicesManagement/Screens/RequestInProcess.dart';

import '../../Shared/Widgets/texts/titles.dart';
import '../Services/Request_Service.dart';

// ignore: must_be_immutable
class Options extends StatefulWidget {
  User user;
  UserProfile? userProfile;
  Options(this.user, this.userProfile, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  List<String> typesOptions = [
    "Pending Proposal",
    "Pending Request",
    "Request In Process",
    "Request Canceled",
    "Request Finished"
  ];
  HttpRequest? httpRequest;
  HttpAccount? httpAccount;
  HttpBusinessProfile? httpBusinessProfile;
  BusinessProfile? businessProfile;
  Account? account;

  List<RequestInterface>? requestsPending;
  List<RequestInterface>? requestsPendingProposal;
  List<RequestInterface>? inProcess;
  List<RequestInterface>? canceled;
  List<RequestInterface>? finished;

  @override
  void initState() {
    httpRequest = HttpRequest();
    httpAccount = HttpAccount();
    httpBusinessProfile = HttpBusinessProfile();
    if (widget.userProfile != null && widget.user.role != "business") {
      getRequestUserProfile();
    } else {
      getAccount();
    }
    super.initState();
  }

  Future getAccount() async {
    account = await httpAccount?.getAccountByUserId(widget.user.id);
    account != null
        ? setState(() {
            account = account;
            getBusinessProfile();
          })
        : null;
  }

  Future getBusinessProfile() async {
    businessProfile =
        await httpBusinessProfile?.getbusinessProfileAccountById(account!.id);
    if (businessProfile != null) {
      setState(() {
        businessProfile = businessProfile;
        getRequestBusinessProfile();
      });
    }
  }

  Future getRequestUserProfile() async {
    requestsPending = await httpRequest?.getAllUserProfileIdAndStatus(
        widget.userProfile!.id!, "PENDING");
    requestsPendingProposal = await httpRequest?.getAllUserProfileIdAndStatus(
        widget.userProfile!.id!, "PENDING_PROPOSAL");
    inProcess = await httpRequest?.getAllUserProfileIdAndStatus(
        widget.userProfile!.id!, "IN_PROCESS");
    canceled = await httpRequest?.getAllUserProfileIdAndStatus(
        widget.userProfile!.id!, "CANCELED");
    finished = await httpRequest?.getAllUserProfileIdAndStatus(
        widget.userProfile!.id!, "FINISHED");
    setState(() {
      requestsPending = requestsPending;
      requestsPendingProposal = requestsPendingProposal;
      inProcess = inProcess;
      canceled = canceled;
      finished = finished;
    });
  }

  Future getRequestBusinessProfile() async {
    requestsPending = await httpRequest?.getAllBusinessProfileIdAndStatus(
        businessProfile!.id!, "PENDING");
    requestsPendingProposal = await httpRequest?.getAllUserProfileIdAndStatus(
        businessProfile!.id!, "PENDING_PROPOSAL");
    inProcess = await httpRequest?.getAllUserProfileIdAndStatus(
        businessProfile!.id!, "IN_PROCESS");
    canceled = await httpRequest?.getAllUserProfileIdAndStatus(
        businessProfile!.id!, "CANCELED");
    finished = await httpRequest?.getAllUserProfileIdAndStatus(
        businessProfile!.id!, "FINISHED");
    setState(() {
      requestsPending = requestsPending;
      requestsPendingProposal = requestsPendingProposal;
      inProcess = inProcess;
      canceled = canceled;
      finished = finished;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Titles(30, "Model House Options"),
          backgroundColor: const Color(0xffffffff),
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 25),
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: typesOptions.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return MaterialButton(
                    onPressed: () {
                      if (typesOptions[index] == "Pending Proposal") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PendingProposal(
                                  requestsPendingProposal,
                                  widget.userProfile,
                                  businessProfile)),
                        );
                      }
                      if (typesOptions[index] == "Pending Request") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PendingRequest(
                                  requestsPending,
                                  widget.userProfile!,
                                  businessProfile)),
                        );
                      }
                      if (typesOptions[index] == "Request In Process") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RequestInProcess(inProcess,
                                  widget.userProfile, businessProfile)),
                        );
                      }
                      if (typesOptions[index] == "Request Canceled") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RequestCanceled(canceled,
                                  widget.userProfile, businessProfile)),
                        );
                      }
                      if (typesOptions[index] == "Request Finished") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RequestFinished(finished,
                                  widget.userProfile, businessProfile)),
                        );
                      }
                    },
                    child: SizedBox(
                      height: 200,
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Titles(16, typesOptions[index]),
                                ),
                              ),
                              Icon(
                                Icons.pending_actions_outlined,
                                color: Color(0XFF02AA8B),
                                size: 50,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
              },
            ),
          )
        ],
      ),
    );
  }
}
