import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';

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
                      SeeDetails(widget.requests![index]),
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
                      SeeDetails(widget.requests![index]),
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

class SeeDetails extends StatelessWidget {
  final RequestInterface request;

  SeeDetails(this.request);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la solicitud'),
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
            Text("Nombre de la empresa: ${request.name}"),
            Text("Categoría: ${request.category}"),
            Text("Presupuesto estimado: ${request.estimatedBudget}"),
            Text("Área en m^2: ${request.area}"),
            Text("Ubicación: ${request.location}"),
            Text("Archivos: ${request.file}"),
            Text("Descripción: ${request.description}"),
          ],
        ),
      ),
    );
  }
}
