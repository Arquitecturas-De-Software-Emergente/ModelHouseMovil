import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/ServicesManagement/Interfaces/ProjectInterface.dart';
import 'package:model_house/ServicesManagement/Interfaces/Proposal.dart';
import 'package:model_house/ServicesManagement/Services/Proposal_Service.dart';
import 'package:model_house/Shared/Components/navigate.dart';

import '../../Security/Interfaces/BusinessProfile.dart';
import '../../Shared/Components/request_card.dart';
import '../../Shared/Widgets/texts/titles.dart';
import '../Interfaces/RequestInterface.dart';
import '../Services/Project_Service.dart';
import '../Services/Request_Service.dart';

// ignore: must_be_immutable
class RequestInProcess extends StatefulWidget {
  UserProfile? userProfile;
  BusinessProfile? businessProfile;
  RequestInProcess(this.userProfile, this.businessProfile,
      {Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RequestInProcessState createState() => _RequestInProcessState();
}

class _RequestInProcessState extends State<RequestInProcess> {
  ProjectInterface? request;
  HttpRequest? httpRequest;
  HttpProposal? httpProject;
  List<RequestInterface>? requestsPending;
  List<Proposal>? inProcess;

  @override
  void initState() {
    httpRequest = HttpRequest();
    httpProject = HttpProposal();
    getProject();
    super.initState();
  }
  Future getProject() async{
    inProcess = await httpProject?.getProposals();
    setState(() {
      inProcess = inProcess;
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
                itemCount: inProcess?.length ?? 0, // Número de elementos en la lista
                itemBuilder: (context, index) {
                  var status = inProcess![index].status;
                  if (status == "Aprobado") {
                    return RequestCard(
                        '${inProcess![index].name}',
                        '${inProcess![index].description}',
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
                                  SeeProjectProgress(inProcess![index], widget.userProfile, widget.businessProfile));
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
                itemCount: inProcess?.length ?? 0, // Número de elementos en la lista
                itemBuilder: (context, index) {
                  var status = inProcess![index].status;
                  if (status == "Aprobado") {
                    return RequestCard(
                        '${inProcess![index].firstName} ${inProcess![index]
                            .lastName}',
                        '${inProcess![index].description}',
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
                                  SeeProjectProgress(inProcess![index], widget.userProfile, widget.businessProfile));
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
class ActivityList extends StatefulWidget {
  final List<Map<String, dynamic>> activities;
  UserProfile? userProfile;
  BusinessProfile? businessProfile;
  ActivityList(this.activities, this.userProfile, this.businessProfile);

  @override
  _ActivityListState createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList> {
  
  Map<int, bool> _isCheckedMap = {}; // Usaremos un mapa para rastrear el estado de cada Checkbox

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.activities.asMap().entries.map((entry) {
        final int index = entry.key;
        final Map<String, dynamic> activity = entry.value;
        bool _isChecked = _isCheckedMap[index] ?? false;

        return Row(
          children: [
            if (widget.businessProfile != null)
            Checkbox(
              value: _isChecked,
              onChanged: (bool? newValue) {
                setState(() {
                  _isCheckedMap[index] = newValue ?? false;
                });
              },
            ),
            if (widget.userProfile != null)
              Icon(
                widget.activities[index].values.last == true ? Icons.check : Icons.crop_square, // Icono de cuadrado o marca de verificación (check)
                size: 30.0, // Tamaño ajustado
                color: widget.activities[index].values.last == true ? Colors.green : Colors.blue, // Color según el estado
              ),
            SizedBox(width: 8),
            Text("${activity["description"].toString()}"),
          ],
        );
      }).toList(),
    );
  }
}


class ResourceList extends StatefulWidget {
  final List<Map<String, dynamic>> resources;
  UserProfile? userProfile;
  BusinessProfile? businessProfile;
  ResourceList(this.resources, this.userProfile, this.businessProfile);

  @override
  _ResourceListState createState() => _ResourceListState();
}

class _ResourceListState extends State<ResourceList> {
  Map<int, bool> _isCheckedMap = {}; // Usaremos un mapa para rastrear el estado de cada Checkbox

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.resources.asMap().entries.map((entry) {
        final int index = entry.key;
        final Map<String, dynamic> resource = entry.value;
        bool _isChecked = _isCheckedMap[index] ?? false;

        return Row(
          children: [
            if (widget.businessProfile != null)
              Checkbox(
                value: _isChecked,
                onChanged: (bool? newValue) {
                  setState(() {
                    _isCheckedMap[index] = newValue ?? false;
                  });
                },
              ),
            if (widget.userProfile != null)
              Icon(
                widget.resources[index].values.last == true ? Icons.check : Icons.crop_square, // Icono de cuadrado o marca de verificación (check)
                size: 30.0, // Tamaño ajustado
                color: widget.resources[index].values.last == true ? Colors.green : Colors.blue, // Color según el estado
              ),
            SizedBox(width: 8),
            Text("Resource: ${resource["resourceType"].toString()}"),
            SizedBox(width: 8),
            Text("Quantity: ${resource["quantity"].toString()}"),
          ],
        );
      }).toList(),
    );
  }
}


class SeeProjectProgress extends StatefulWidget {
  final Proposal request;
  UserProfile? userProfile;
  BusinessProfile? businessProfile;

  SeeProjectProgress(this.request, this.userProfile, this.businessProfile);

  @override
  State<SeeProjectProgress> createState() => _SeeProjectProgressState();
}

class _SeeProjectProgressState extends State<SeeProjectProgress> {
    late TextEditingController descriptionController = TextEditingController();
    @override
    void initState() {
      super.initState();
      descriptionController = TextEditingController(text: widget.request.description);
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la solicitud'),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0XFF02AA8B),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nombre de la empresa: ${widget.request.name}"),
            if (widget.businessProfile != null)
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            if (widget.userProfile != null)
            Text("Nombre de la empresa: ${widget.request.description}"),
            if (widget.request.projectActivities != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Activities"),
                  ActivityList(widget.request.projectActivities!, widget.userProfile, widget.businessProfile),
                ],
              ),
            if (widget.request.projectResources != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Resources"),
                  ResourceList(widget.request.projectResources!, widget.userProfile, widget.businessProfile),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
