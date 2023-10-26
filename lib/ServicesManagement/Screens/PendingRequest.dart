import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';

import '../../Shared/Components/request_card.dart';
import '../../Shared/Widgets/texts/titles.dart';
import '../Interfaces/RequestInterface.dart';
import '../Services/Request_Service.dart';

class PendingRequest extends StatefulWidget {
  List<RequestInterface>? requests;
  UserProfile? userProfile;
  BusinessProfile? businessProfile;
  PendingRequest(this.requests, this.userProfile, this.businessProfile,
      {Key? key})
      : super(key: key);

  @override
  _PendingRequestState createState() => _PendingRequestState();
}

class _PendingRequestState extends State<PendingRequest> {
  RequestInterface? request;
  HttpRequest? httpRequest;
  List<RequestInterface>? requestsPending;
  @override
  void initState() {
    httpRequest = HttpRequest();
    print(widget.requests?.length);
    print('requests: ${widget.requests}');
    print('userProfile: ${widget.userProfile}');
    print('businessProfile: ${widget.businessProfile}');
    super.initState();
  }

  Future changeStatus(int requestId, String status) async {
    request = await httpRequest?.changeStatus(requestId, status);
    if (request != null) {
      if (widget.userProfile != null){
      requestsPending = await httpRequest?.getAllUserProfileIdAndStatus(
          widget.userProfile!.id!, "Pendiente");
      }
      else{
        requestsPending = await httpRequest?.getAllBusinessProfileIdAndStatus(
        widget.businessProfile!.id!, "Pendiente");
      }
      setState(() {
        request = request;
        widget.requests = requestsPending;
      });
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
                itemCount: widget.requests?.length ?? 0,
                itemBuilder: (context, index) {
                  return RequestCard(
                      '${widget.requests![index].name}',
                      '${widget.requests![index].description}',
                      SeeDetails(widget.requests![index], 'Request to ${widget.requests![index].name}'),
                      Container());
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
                      SeeDetails(widget.requests![index], "Request by ${widget.requests![index].firstName} ${widget.requests![index].lastName}"),
                      AcceptRejectButtons(
                        onAcceptPressed: () {
                          // Lógica para cuando se presiona el botón "Accept"
                          print('Accept button pressed');
                          changeStatus(widget.requests![index].id!, "Aprobado");
                        },
                        onRejectPressed: () {
                          // Lógica para cuando se presiona el botón "Reject"
                          print('Reject button pressed');
                          changeStatus(widget.requests![index].id!, "Cancelado");
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
class SeeDetails extends StatelessWidget {
  final RequestInterface request;
  String? name;

  SeeDetails(this.request, this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles de la Solicitud',
          style: TextStyle(
            color: Colors.black, // Color del texto del título del AppBar
            fontSize: 20.0, // Tamaño de fuente del título del AppBar
          ),
        ),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(name ?? "N/A", ""),
            _buildDetailRow("Categoría:", request.category ?? "N/A"),
            _buildDetailRow("Presupuesto Estimado:", request.estimatedBudget != null
                ? "${request.estimatedBudget!}"
                : "N/A"), // Formatea el presupuesto como moneda
            _buildDetailRow("Área en m^2:", request.area != null ? "${request.area} m^2" : "N/A"),
            _buildDetailRow("Ubicación:", request.location ?? "N/A"),
            _buildDetailRow("Archivos:", request.file ?? "N/A"),
            _buildDetailRow("Descripción:", request.description ?? "N/A"),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black, // Color del texto de la etiqueta
            fontSize: 16.0, // Tamaño de fuente de la etiqueta
            fontWeight: FontWeight.bold, // Establece el texto de etiqueta en negrita
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.black, // Color del texto de valor
            fontSize: 18.0, // Tamaño de fuente del valor
          ),
        ),
        SizedBox(height: 12.0), // Agrega espacio entre cada par de etiqueta y valor
      ],
    );
  }
}
class AcceptRejectButtons extends StatelessWidget {
  final VoidCallback onAcceptPressed;
  final VoidCallback onRejectPressed;

  AcceptRejectButtons({required this.onAcceptPressed, required this.onRejectPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
        decoration: BoxDecoration(
        color: Colors.white,  // Fondo blanco
          borderRadius: BorderRadius.circular(10.0),  // Bordes redondeados de 10px
          border: Border.all(color: Colors.green, width: 2.0),  // Borde verde
        ),
        child: TextButton(
        onPressed: onAcceptPressed,
        style: TextButton.styleFrom(primary: Colors.green),  // Color del texto verde
        child: Text('Accept'),  // Texto del botón
        ),
        ),
        SizedBox(width: 16), // Espacio entre los botones
        Container(
        decoration: BoxDecoration(
        color: Colors.white,  // Fondo blanco
        borderRadius: BorderRadius.circular(10.0),  // Bordes redondeados de 10px
        border: Border.all(color: Colors.red, width: 2.0),  // Borde verde
        ),
        child: TextButton(
        onPressed: onRejectPressed,
        style: TextButton.styleFrom(primary: Colors.red),  // Color del texto verde
        child: Text('Reject'),  // Texto del botón
        ),
        ),
      ],
    );
  }
}

