import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/ServicesManagement/Interfaces/ProjectInterface.dart';
import 'package:model_house/ServicesManagement/Interfaces/Proposal.dart';
import 'package:model_house/ServicesManagement/Services/Project_Service.dart';
import 'package:model_house/ServicesManagement/Services/Proposal_Service.dart';
import 'package:model_house/Shared/Components/navigate.dart';

import '../../Security/Interfaces/Account.dart';
import '../../Security/Interfaces/BusinessProfile.dart';
import '../../Shared/Components/request_card.dart';
import '../../Shared/Components/seeProjectProgress.dart';
import '../../Shared/Widgets/texts/titles.dart';
import '../Interfaces/RequestInterface.dart';
import '../Services/Request_Service.dart';

// ignore: must_be_immutable
class RequestInProcess extends StatefulWidget {
  Account? account;
  UserProfile? userProfile;
  BusinessProfile? businessProfile;
  RequestInProcess(this.account, this.userProfile, this.businessProfile,
      {Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RequestInProcessState createState() => _RequestInProcessState();
}

class _RequestInProcessState extends State<RequestInProcess> {
  HttpProject? httpProject;
  List<ProjectInterface>? projects;

  @override
  void initState() {
    httpProject = HttpProject();
    getProjects();
    super.initState();
  }
  Future getProjects() async{
    projects = await httpProject?.getAllProjects();
    setState(() {
      projects = projects;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Titles(28, "Your Projects"),
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
                itemCount: projects?.length ?? 0, // Número de elementos en la lista
                itemBuilder: (context, index) {
                  var status = projects![index].status;
                  if (status == "Aprobado") {
                    return RequestCard(
                        '${projects![index].name}',
                        '${projects![index].description}',
                        Container(),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // Fondo blanco
                            borderRadius: BorderRadius.circular(10.0),
                            // Bordes redondeados de 10px
                            border: Border.all(color: Color(0XFF02AA8B),
                                width: 2.0), // Borde verde
                          ),
                          child: TextButton(
                            onPressed: () {
                              navigate(context,
                                  SeeProjectProgress(widget.account, projects![index], widget.userProfile, widget.businessProfile));
                              // Coloca aquí la acción que deseas realizar cuando se presiona el botón
                            },
                            style: TextButton.styleFrom(primary: Color(
                                0XFF02AA8B)), // Color del texto verde
                            child: Text(
                                'See Project Progress'), // Texto del botón
                          ),
                        ));
                  };
                  return SizedBox.shrink();
                }
              ),
            ),
          if (widget.businessProfile != null)
            Expanded(
              child: ListView.builder(
                itemCount: projects?.length ?? 0, // Número de elementos en la lista
                itemBuilder: (context, index) {
                  var status = projects![index].status;
                  if (status == "Aprobado") {
                    return RequestCard(
                        '${projects![index].firstName} ${projects![index]
                            .lastName}',
                        '${projects![index].description}',
                        Container(),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // Fondo blanco
                            borderRadius: BorderRadius.circular(10.0),
                            // Bordes redondeados de 10px
                            border: Border.all(color: Color(0XFF02AA8B),
                                width: 2.0), // Borde verde
                          ),
                          child: TextButton(
                            onPressed: () {
                              navigate(context,
                                  SeeProjectProgress(widget.account, projects![index], widget.userProfile, widget.businessProfile));
                              // Coloca aquí la acción que deseas realizar cuando se presiona el botón
                            },
                            style: TextButton.styleFrom(primary: Color(
                                0XFF02AA8B)), // Color del texto verde
                            child: Text(
                                'Manage Your Project'), // Texto del botón
                          ),
                        ));
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
        ],
      ),
    );
  }
}



