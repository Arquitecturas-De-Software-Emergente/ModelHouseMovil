import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:model_house/ServicesManagement/Screens/PendingProposal.dart';
import 'package:model_house/ServicesManagement/Services/Proposal_Service.dart';
import 'package:model_house/ServicesManagement/Services/ProyectActivity_Service.dart';
import 'package:model_house/ServicesManagement/Services/ProyectResource_Service.dart';
import 'package:model_house/Shared/Components/PrincipalView.dart';
import '../../../Security/Interfaces/Account.dart';
import '../../../Security/Interfaces/BusinessProfile.dart';
import '../../../Security/Interfaces/UserProfile.dart';
import '../../../Shared/DialogModelHouse.dart';
import '../../../Shared/Widgets/texts/titles.dart';

import '../../Interfaces/Proposal.dart';

class FormProposal extends StatefulWidget {
  final int proposalId;
  final UserProfile? userProfile;
  final BusinessProfile? businessProfile;
  Account? account;
  FormProposal(this.proposalId, this.userProfile, this.businessProfile, this.account, {Key? key}) : super(key: key);

  @override
  State<FormProposal> createState() => _FormProposalState();
}

class _FormProposalState extends State<FormProposal> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController activityTitleController = TextEditingController();
  final List<String> activities = [];
  final TextEditingController resourceTitleController = TextEditingController();
  final TextEditingController resourceQuantityController = TextEditingController();
  final List<Map<String, String>> resources = [];
  List<PlatformFile> selectedFiles = [];


  String titleError = "";
  String descriptionError = "";
  String activitiesError = "";
  String resourcesError = "";
  File? _image;


  HttpProposal? httpProposal;
  HttpProyectActivity? httpProjectActivity;
  HttpProyectResource? httpProjectResource;

  Proposal? proposal;
  @override
  void initState() {
    httpProposal = HttpProposal();
    httpProjectActivity = HttpProyectActivity();
    httpProjectResource = HttpProyectResource();
    super.initState();
  }

  void addActivity() {
    String activity = activityTitleController.text;
    if (activity.isNotEmpty) {
      setState(() {
        activities.add(activity);
        activityTitleController.clear();
      });
    }
  }

  void deleteActivity(int index) {
    setState(() {
      activities.removeAt(index);
    });
  }

  void addResource() {
    String resource = resourceTitleController.text;
    String quantity = resourceQuantityController.text;
    if (resource.isNotEmpty && quantity.isNotEmpty) {
      setState(() {
        resources.add({"name": resource, "quantity": quantity});
        resourceTitleController.clear();
        resourceQuantityController.clear();
      });
    }
  }

  void deleteResource(int index) {
    setState(() {
      resources.removeAt(index);
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final PickedFile? pickedImage = await _picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void deleteFile(int index) {
    setState(() {
      selectedFiles.removeAt(index);
    });
  }
  Future changeStatus(int proposalId, String status) async {
    proposal = await httpProposal?.changeStatus(proposalId, status);
  }
  void validateAndSubmit() {
    if (titleController.text.isEmpty) {
      setState(() {
        titleError = "Este campo es obligatorio";
      });
    } else {
      setState(() {
        titleError = "";
      });
    }

    if (descriptionController.text.isEmpty) {
        setState(() {
          descriptionError = "Este campo es obligatorio";
        });
    } else {
      setState(() {
      descriptionError = "";
      });
    }

    if (activities.isEmpty) {
      setState(() {
        activitiesError = "Este campo es obligatorio";
      });
    } else {
      setState(() {
        activitiesError = "";
      });
    }

    if (resources.isEmpty) {
      setState(() {
        resourcesError = "Este campo es obligatorio";
      });
    } else {
      setState(() {
        resourcesError = "";
      });
    }

    if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty
    && activities.isNotEmpty && resources.isNotEmpty) {

      // Aquí puedes realizar la lógica para enviar el formulario y agregar actividades y recursos.
      httpProposal?.updateProposal(widget.proposalId, titleController.text.toString(), descriptionController.text.toString());

      // Agregar actividades
      activities.forEach((activity) {
        httpProjectActivity?.createProyectActivity(widget.proposalId, activity);
      });

      // Agregar recursos
      resources.forEach((resource) {
        print(resource);
        httpProjectResource?.createProjectResource(widget.proposalId, resource['name']!, int.tryParse(resource['quantity']!));
      });
      changeStatus(widget.proposalId, "Enviado");
      showCustomDialog(context, "Success", "The request was sent successfully", true, PrincipalView(widget.account!, 1));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Titles(28, "Form Proposal"),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0XFF02AA8B),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            Text(
              titleError,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            Text(
              descriptionError,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: _pickImage,
              child: _image == null ? ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Icon(Icons.person_4_outlined, color: Colors.black, size: 75),
              ) : Image.file(
                _image!,
                width: 300,
                height: 300,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Archivos Seleccionados",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: selectedFiles.asMap().entries.map((entry) {
                final index = entry.key;
                final file = entry.value;
                return Row(
                  children: [
                    Expanded(
                      child: Text("Archivo: ${file.name}"),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red,),
                      onPressed: () => deleteFile(index),
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              "Actividades",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: activityTitleController,
                    decoration: InputDecoration(labelText: 'Título de Actividad'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.green,),
                  onPressed: () => addActivity(),
                ),
              ],
            ),
            Text(
              activitiesError,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            Column(
              children: activities.asMap().entries.map((entry) {
                final index = entry.key;
                final activity = entry.value;
                return Row(
                  children: [
                    Expanded(child: Text(activity)),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red,),
                      onPressed: () => deleteActivity(index),
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              "Recursos",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: resourceTitleController,
                    decoration: InputDecoration(labelText: 'Título de Recurso'),
                  ),
                ),
                Flexible(
                  child: TextField(
                    controller: resourceQuantityController,
                    decoration: InputDecoration(labelText: 'Cantidad'),
                    keyboardType: TextInputType.number, // Configura el teclado para aceptar solo números.
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly, // Acepta solo dígitos.
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.green,),
                  onPressed: () => addResource(),
                ),
              ],
            ),
            Text(
              resourcesError,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            Column(
              children: resources.asMap().entries.map((entry) {
                final index = entry.key;
                final resource = entry.value;
                return Row(
                  children: [
                    Expanded(
                      child: Text('Recurso: ${resource["name"]}, Cantidad: ${resource["quantity"]}'),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red,),
                      onPressed: () => deleteResource(index),
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: validateAndSubmit,
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
              ),
              child: Text("Enviar"),
            )
          ],
        ),
      ),
    );
  }
}
