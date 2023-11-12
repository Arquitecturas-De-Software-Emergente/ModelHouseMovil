import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/ServicesManagement/Interfaces/ProjectInterface.dart';
import 'package:model_house/ServicesManagement/Services/Project_Service.dart';
import 'package:rating_dialog/rating_dialog.dart';

import '../../Security/Interfaces/BusinessProfile.dart';
import '../../Shared/Components/request_card.dart';
import '../../Shared/Components/seeDetails.dart';
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
    print(projects?.length);
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
        var rating = httpProject?.createRating(projects![index].id!, widget.userProfile!.id!, response.rating, response.comment);
        setState(() {
          rating = rating;
        });
        Navigator.of(context).pop();
        getProjects();
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
                  if (projects![index].status == "Completado") {
                    return RequestCard(
                      '${projects![index].name}',
                      '${projects![index].description}',
                      SeeDetails(projects![index].proposal!.request!, "${projects![index].proposal?.request!.name}"),
                      Column(
                        children: [
                          SizedBox(width: 10,),
                          projects![index].reviewId == null ? Container(
                            width: 150,
                            height: 40,
                            decoration:  BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.green, width: 2.0),
                            ),
                            child: TextButton(
                              onPressed: (){
                                showRatingDialog(context, index);
                              },
                              style: TextButton.styleFrom(
                                primary: Colors.green,
                              ),
                              child: const Text('Leave a Comment'),
                            ),
                          ): const Text('Review complete', style: TextStyle(color: Color(0XFF02AA8B), fontWeight: FontWeight.bold)),
                        ],
                      ),
                    );
                  } else {
                    // Si no cumple con la condición, retorna un contenedor vacío
                    return Container();
                  }
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
                      SeeDetails(projects![index].proposal!.request!, "${projects![index].proposal?.request!.name}"),
                      Text('Waiting for an answer', style: TextStyle(color: Color(0XFFECA11E), fontWeight: FontWeight.bold))
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}