import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/Account.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/Security/Services/Account_Service.dart';
import 'package:model_house/Security/Services/Business_Profile.dart';
import 'package:model_house/ServicesManagement/Interfaces/Proposal.dart';
import 'package:model_house/ServicesManagement/Screens/PendingProposal.dart';
import 'package:model_house/ServicesManagement/Interfaces/RequestInterface.dart';
import 'package:model_house/ServicesManagement/Screens/PendingRequest.dart';
import 'package:model_house/ServicesManagement/Screens/RequestCanceled.dart';
import 'package:model_house/ServicesManagement/Screens/RequestFinished.dart';
import 'package:model_house/ServicesManagement/Screens/RequestInProcess.dart';
import 'package:model_house/ServicesManagement/Services/Proposal_Service.dart';

import '../../Shared/Widgets/texts/titles.dart';
import '../Interfaces/ProjectInterface.dart';
import '../Services/Project_Service.dart';
import '../Services/Request_Service.dart';

// ignore: must_be_immutable
class Options extends StatefulWidget {
  Account? account;
  UserProfile? userProfile;
  Options(this.account, this.userProfile, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  List<String> typesOptions = [
    "Request",
    "Proposal",
    "Project",
    "Completed Projects",
    "Canceled"
  ];
  HttpRequest? httpRequest;
  HttpAccount? httpAccount;
  HttpProposal? httpProposal;
  HttpProject? httpProject;
  HttpBusinessProfile? httpBusinessProfile;
  BusinessProfile? businessProfile;
  Account? account;

  List<RequestInterface>? requestsPending;
  List<Proposal>? requestsPendingProposal;
  List<ProjectInterface>? inProcess;
  List<RequestInterface>? canceled;
  List<RequestInterface>? finished;



  @override
  void initState() {
    httpRequest = HttpRequest();
    httpAccount = HttpAccount();
    httpProject = HttpProject();
    httpBusinessProfile = HttpBusinessProfile();
    httpProposal = HttpProposal();

    print('Account: ${widget.account}');
    print('UserProfile: ${widget.userProfile}');

    if (widget.userProfile != null) {
      getRequestUserProfile();
    } else {
      getBusinessProfile();
    }
    super.initState();
  }

  Future getBusinessProfile() async {
    if (widget.account != null) {
      businessProfile = await httpBusinessProfile?.getbusinessProfileAccountById(widget.account!.id!);
      if (businessProfile != null) {
        setState(() {
          businessProfile = businessProfile;
        });
        getRequestBusinessProfile();
      }
    }
  }


  Future getRequestUserProfile() async {
    requestsPending = await httpRequest?.getAllUserProfileIdAndStatus(
        widget.userProfile!.id!, "Pendiente");

    requestsPendingProposal = await httpProposal?.getProposals();

    inProcess = await httpProject?.getAllProjects();

    canceled = await httpRequest?.getAllUserProfileIdAndStatus(
        widget.userProfile!.id!, "Cancelado");
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
        businessProfile!.id!, "Pendiente");

    requestsPendingProposal = await httpProposal?.getProposals();

    inProcess = await httpProject?.getAllProjects();
    canceled = await httpRequest?.getAllUserProfileIdAndStatus(
        businessProfile!.id!, "Cancelado");
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
                String imageAssetPath = '';
                if (typesOptions[index] == "Request") {
                  imageAssetPath = 'images/first-step-icon.png'; // Replace with the actual asset path
                } else if (typesOptions[index] == "Proposal") {
                  imageAssetPath = 'images/second-step-icon.png'; // Replace with the actual asset path
                } else if (typesOptions[index] == "Project") {
                  imageAssetPath = 'images/third-step-icon.png'; // Replace with the actual asset path
                } else if (typesOptions[index] == "Completed Projects") {
                  imageAssetPath = 'images/fourth-step-icon.png'; // Replace with the actual asset path
                } else if (typesOptions[index] == "Canceled") {
                  imageAssetPath = 'images/fifth-step-icon.png'; // Replace with the actual asset path
                }
                return MaterialButton(
                    onPressed: () {
                      if (typesOptions[index] == "Request") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PendingRequest(
                                  requestsPending,
                                  widget.userProfile,
                                  businessProfile)),
                        );
                      }
                      if (typesOptions[index] == "Proposal") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PendingProposal(
                                  requestsPendingProposal,
                                  widget.userProfile,
                                  businessProfile)),
                        );
                      }
                      if (typesOptions[index] == "Project") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RequestInProcess(inProcess,
                                  widget.userProfile, businessProfile)),
                        );
                      }
                      if (typesOptions[index] == "Completed Projects") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RequestCanceled(finished,
                                  widget.userProfile, businessProfile)),
                        );
                      }
                      if (typesOptions[index] == "Canceled") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RequestFinished(canceled,
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
                              Image.asset(
                                imageAssetPath, // Load the PNG image
                                width: 50, // Adjust the width as needed
                                height: 50, // Adjust the height as needed
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
