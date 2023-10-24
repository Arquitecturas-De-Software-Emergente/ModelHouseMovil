import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/ServicesManagement/Interfaces/RequestInterface.dart';
import 'package:model_house/ServicesManagement/Services/Request_Service.dart';

class CreateRequest extends StatefulWidget {
  BusinessProfile businessProfile;
  UserProfile userProfile;
  CreateRequest(this.businessProfile, this.userProfile, {super.key});
  @override
  _CreateRequestState createState() => _CreateRequestState();
}

class _CreateRequestState extends State<CreateRequest> {
  final httpRequest = HttpRequest();
  
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController estimatedBudgetController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController fileController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

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
              controller: fileController,
              decoration: InputDecoration(labelText: 'File'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: statusController,
              decoration: InputDecoration(labelText: 'Status'),
            ),
            ElevatedButton(
              onPressed: () {
                final data = RequestInterface(
                  category: categoryController.text,
                  estimatedBudget: estimatedBudgetController.text,
                  area: int.tryParse(areaController.text) ?? 0,
                  location: locationController.text,
                  file: fileController.text,
                  description: descriptionController.text,
                  status: statusController.text,
                );
                bool accepted = statusController.text == "Aceptado";
                httpRequest.createRequest(widget.userProfile.id!, widget.businessProfile.id!, statusController.text, descriptionController.text, accepted);
                
              },
              child: Text("Send Request"),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF02AA8B),
                minimumSize: Size(350, 60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
