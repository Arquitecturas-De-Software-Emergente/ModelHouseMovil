import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/ServicesManagement/Interfaces/ProjectInterface.dart';
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
  HttpProject? httpProject;
  List<RequestInterface>? requestsPending;
  List<ProjectInterface>? inProcess;
  @override
  void initState() {
    httpRequest = HttpRequest();
    httpProject = HttpProject();
    getProject();
    super.initState();
  }
  Future getProject() async{
    inProcess = await httpProject?.getAllProjects();
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
                  return RequestCard(
                      '${inProcess![index].title}',
                      '${inProcess![index].description}',
                      Container(),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,  // Fondo blanco
                          borderRadius: BorderRadius.circular(10.0),  // Bordes redondeados de 10px
                          border: Border.all(color: Color(0XFF02AA8B), width: 2.0),  // Borde verde
                        ),
                        child: TextButton(
                          onPressed: () {
                            navigate(context, SeeProjectProgress(inProcess![index]));
                            // Coloca aquí la acción que deseas realizar cuando se presiona el botón
                          },
                          style: TextButton.styleFrom(primary: Color(0XFF02AA8B)),  // Color del texto verde
                          child: Text('See Project Progress'),  // Texto del botón
                        ),
                      ));
                },
              ),
            ),
          if (widget.userProfile == null)
            Expanded(
              child: ListView.builder(
                itemCount: inProcess?.length ?? 0, // Número de elementos en la lista
                itemBuilder: (context, index) {
                  return RequestCard(
                      '${inProcess![index].title}',
                      '${inProcess![index].description}',
                      Container(),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,  // Fondo blanco
                          borderRadius: BorderRadius.circular(10.0),  // Bordes redondeados de 10px
                          border: Border.all(color: Color(0XFF02AA8B), width: 2.0),  // Borde verde
                        ),
                        child: TextButton(
                          onPressed: () {
                            navigate(context, SeeProjectProgress(inProcess![index]));
                            // Coloca aquí la acción que deseas realizar cuando se presiona el botón
                          },
                          style: TextButton.styleFrom(primary: Color(0XFF02AA8B)),  // Color del texto verde
                          child: Text('Elaborate Proposal'),  // Texto del botón
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
// class SeeDetails extends StatelessWidget {
//   final RequestInterface request;
//
//   SeeDetails(this.request);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Detalles de la solicitud'),
//         backgroundColor: Colors.white, // Ajusta el color de fondo del AppBar según tus preferencias
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Color(0XFF02AA8B), // Color del botón de retroceso
//           ),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Nombre de la empresa: ${request.name}"),
//             Text("Categoría: ${request.category}"),
//             Text("Presupuesto estimado: ${request.estimatedBudget}"),
//             Text("Área en m^2: ${request.area}"),
//             Text("Ubicación: ${request.location}"),
//             Text("Archivos: ${request.file}"),
//             Text("Descripción: ${request.description}"),
//           ],
//         ),
//       ),
//     );
//   }
// }
class SeeProjectProgress extends StatelessWidget {
  final ProjectInterface request;

  SeeProjectProgress(this.request);

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
            Text("Nombre de la empresa: ${request.title}"),
            Text("Descripción: ${request.description}"),
            Hero(
              tag: 'image_${request.id}', // Usa un identificador único para la animación Hero
              child: GestureDetector(
                onTap: () {
                  // Navegar a la vista de zoom de la imagen
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ZoomImage(request.image!),
                    ),
                  );
                },
                child: Image.network(
                  "${request.image}",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text("Activities"),
            CheckListItem(
              title: "Hacer la compra",
              isChecked: false,
              onChecked: (isChecked) {
                // Lógica para manejar el cambio de estado aquí
              },
            ),
            Text("Resources"),
            CheckListItem(
              title: "Hacer la compra",
              isChecked: false,
              onChecked: (isChecked) {
                // Lógica para manejar el cambio de estado aquí
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ZoomImage extends StatelessWidget {
  final String imageUrl;

  ZoomImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Imagen Ampliada'),
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
      body: Center(
        child: Hero(
          tag: 'image_${imageUrl}', // Utiliza el mismo identificador para la animación Hero
          child: InteractiveViewer(
            child: Image.network(
              imageUrl,
            ),
          ),
        ),
      ),
    );
  }
}
class CheckListItem extends StatefulWidget {
  final String title;
  bool isChecked;
  final Function(bool) onChecked;

  CheckListItem({
    required this.title,
    this.isChecked = false,
    required this.onChecked,
  });

  @override
  _CheckListItemState createState() => _CheckListItemState();
}

class _CheckListItemState extends State<CheckListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: widget.isChecked,
        onChanged: (value) {
          setState(() {
            widget.isChecked = value!;
            widget.onChecked(value);
          });
        },
      ),
      title: Text(widget.title),
    );
  }
}








