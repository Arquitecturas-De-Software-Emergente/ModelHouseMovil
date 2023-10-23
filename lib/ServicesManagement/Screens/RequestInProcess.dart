import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/ServicesManagement/Interfaces/ProjectInterface.dart';
import 'package:model_house/Shared/Components/navigate.dart';

import '../../Security/Interfaces/BusinessProfile.dart';
import '../../Shared/Components/request_card.dart';
import '../../Shared/Widgets/texts/titles.dart';
import '../Interfaces/RequestInterface.dart';
import '../Services/Request_Service.dart';

// ignore: must_be_immutable
class RequestInProcess extends StatefulWidget {
  List<ProjectInterface>? requests;
  UserProfile? userProfile;
  BusinessProfile? businessProfile;
  RequestInProcess(this.requests, this.userProfile, this.businessProfile,
      {Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RequestInProcessState createState() => _RequestInProcessState();
}

class _RequestInProcessState extends State<RequestInProcess> {
  ProjectInterface? request;
  HttpRequest? httpRequest;
  List<RequestInterface>? requestsPending;
  @override
  void initState() {
    httpRequest = HttpRequest();
    // if (request != null){
    //   requestsPending = httpRequest?.getAllUserProfileIdAndStatus(
    //       widget.request![index].businessProfileId, "PENDING")
    // }
    print(widget.requests?.length);
    print('Projects requests: ${widget.requests}');
    super.initState();
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
          Expanded(
            child: ListView.builder(
              itemCount: widget.requests?.length ?? 0, // Número de elementos en la lista
              itemBuilder: (context, index) {
                return RequestCard(
                    '${widget.requests![index].title}',
                    '${widget.requests![index].description}',
                    Container(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,  // Fondo blanco
                        borderRadius: BorderRadius.circular(10.0),  // Bordes redondeados de 10px
                        border: Border.all(color: Color(0XFF02AA8B), width: 2.0),  // Borde verde
                      ),
                      child: TextButton(
                        onPressed: () {
                          navigate(context, Container());
                          // Coloca aquí la acción que deseas realizar cuando se presiona el botón
                        },
                        style: TextButton.styleFrom(primary: Color(0XFF02AA8B)),  // Color del texto verde
                        child: Text('See Project Progress'),  // Texto del botón
                      ),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
