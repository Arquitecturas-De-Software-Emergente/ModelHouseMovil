import 'package:flutter/material.dart';
import '../../../Security/Interfaces/BusinessProfile.dart';
import '../../../Security/Interfaces/UserProfile.dart';
import '../../../Shared/Widgets/texts/titles.dart';
import 'package:file_picker/file_picker.dart';

class FormProposal extends StatefulWidget {
  final UserProfile? userProfile;
  final BusinessProfile? businessProfile;

  FormProposal(this.userProfile, this.businessProfile, {Key? key}) : super(key: key);

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

  void selectAndAddFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        selectedFiles.add(result.files.first);
      });
    }
  }

  void deleteFile(int index) {
    setState(() {
      selectedFiles.removeAt(index);
    });
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
            SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: selectAndAddFile,
              child: Text("Subir Archivo"),
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
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.green,),
                  onPressed: () => addResource(),
                ),
              ],
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
              onPressed: () {
                // Coloca aquí la lógica que deseas ejecutar al presionar el botón "Enviar".
                // Puede ser el envío de datos o cualquier otra acción.
              },
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
