import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/ServicesManagement/Interfaces/ProjectInterface.dart';
import 'package:model_house/ServicesManagement/Services/Project_Service.dart';
import 'package:rating_dialog/rating_dialog.dart';

import '../../Security/Interfaces/BusinessProfile.dart';
import '../../Shared/Components/request_card.dart';
import '../../Shared/Widgets/texts/titles.dart';
import '../Interfaces/RequestInterface.dart';
import '../Services/Request_Service.dart';

// ignore: must_be_immutable
class RequestFinished extends StatefulWidget {
  List<RequestInterface>? requests;
  UserProfile? userProfile;
  BusinessProfile? businessProfile;
  RequestFinished(this.requests, this.userProfile, this.businessProfile,
      {Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RequestFinishedState createState() => _RequestFinishedState();
}

class _RequestFinishedState extends State<RequestFinished> {
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
  void showRatingDialog(BuildContext context, index) {
    final _ratingDialog = RatingDialog(
      title: Text("Rate the company's service"),
      image: const Icon(Icons.check_circle, size: 60, color: Colors.green),
      submitButtonText: 'Send',
      onCancelled: () => print('Diálogo de calificación cancelado'),
      onSubmitted: (response) {
        var review = httpProject?.getRating(projects![index].id!);
        setState(() {
          review = review;
        });
        if (review != null){
          var rating = httpProject?.createRating(projects![index].id!, response.rating, response.comment);
          setState(() {
            rating = rating;
          });
        }
        print('Calificación: ${response.rating}');
        print('Descripción: ${response.comment}');
        Navigator.of(context).pop();
      },
    );

    showDialog(
      context: context,
      builder: (context) => _ratingDialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Titles(28, "Completed Projects"),
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
                itemCount: projects?.length ?? 0,
                itemBuilder: (context, index) {
                  return RequestCard(
                      '${projects![index].name}',
                      '${projects![index].description}',
                      SeeDetails(projects![index]),
                      Row(
                        children: [
                          Text("Completed"),
                          SizedBox(width: 10,),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white, // Fondo blanco
                              borderRadius:
                              BorderRadius.circular(10.0), // Bordes redondeados de 10px
                              border: Border.all(color: Colors.green, width: 2.0), // Borde verde
                            ),
                            child: TextButton(
                              onPressed: (){
                                showRatingDialog(context, index);
                              },
                              style: TextButton.styleFrom(
                                  primary: Colors.green), // Color del texto verde
                              child: const Text('Leave a Comment'), // Texto del botón
                            ),
                          ),
                        ],
                      ));
                },
              ),
            ),
          if (widget.businessProfile != null)
            Expanded(
              child: ListView.builder(
                itemCount: projects?.length ?? 0,
                itemBuilder: (context, index) {
                  return RequestCard(
                    '${projects![index].firstName} ${projects![index].lastName}',
                    '${projects![index].description}',
                      SeeDetails(projects![index]),
                      Text("Completed")
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class SeeDetails extends StatelessWidget {
  final ProjectInterface project;

  SeeDetails(this.project);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Completed Details'),
        backgroundColor: Colors.white, // Ajusta el color de fondo del AppBar según tus preferencias
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0XFF02AA8B), // Color del botón de retroceso
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nombre de la empresa: ${project.name}"),
            Text("Categoría: ${project.title}"),
            Text("Presupuesto estimado: ${project.description}"),
            Text('Actividades del Proyecto:'),
            // Column(
            //   children: project.projectActivities!.asMap().entries.map((entry) {
            //     final index = entry.key;
            //     final activity = entry.value;
            //     return
            //         Expanded(child: Text(activity["description"]));
            //
            //   }).toList(),
            // ),
            // Text('Recursos del Proyecto:'),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: project.projectResources?.length,
            //     itemBuilder: (context, index) {
            //       final resource = project.projectResources![index];
            //       return Row(children: [
            //         Text('Description: ${resource["description"]}'),
            //         Text('Quantity: ${resource["quantity"]}'),
            //       ]);
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
