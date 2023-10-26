import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/ServicesManagement/Interfaces/RequestInterface.dart';
import 'package:model_house/ServicesManagement/Services/Request_Service.dart';

class CreateRequest extends StatefulWidget {
  BusinessProfile businessProfile;
  String userProfileId;
  CreateRequest(this.businessProfile, this.userProfileId, {super.key});
  @override
  _CreateRequestState createState() => _CreateRequestState();
}

class _CreateRequestState extends State<CreateRequest> {
  final httpRequest = HttpRequest();

  final TextEditingController categoryController = TextEditingController();
  final TextEditingController estimatedBudgetController =
      TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: estimatedBudgetController,
              decoration: InputDecoration(labelText: 'Estimated Budget'),
            ),
            TextField(
              controller: areaController,
              decoration: InputDecoration(labelText: 'Area'),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            ElevatedButton(
              onPressed: () {
                if (categoryController.text.isNotEmpty &&
                    estimatedBudgetController.text.isNotEmpty &&
                    locationController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  final category = categoryController.text;
                  final estimatedBudget = estimatedBudgetController.text;
                  final location = locationController.text;
                  final description = descriptionController.text;

                  // Validar que areaController.text sea una cadena válida que pueda convertirse en un entero
                  if (areaController.text.isNotEmpty) {
                    final area = int.tryParse(areaController.text);
                    if (area != null) {
                      final data = RequestInterface(
                        category: category,
                        estimatedBudget: estimatedBudget,
                        area: area,
                        location: location,
                        description: description,
                      );
                      httpRequest.createRequest(
                          widget.userProfileId,
                          widget.businessProfile.id!,
                          category,
                          estimatedBudget,
                          area,
                          location,
                          description);
                    } else {
                      print('Error: El valor de área no es un número válido.');
                    }
                  } else {
                    // Tratar el caso en el que areaController está vacío
                    print('Error: El campo de área no puede estar vacío.');
                  }
                } else {
                  print('Error de validación');
                }
              },
              child: Text("Send Request"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF02AA8B),
                minimumSize: Size(350, 60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
