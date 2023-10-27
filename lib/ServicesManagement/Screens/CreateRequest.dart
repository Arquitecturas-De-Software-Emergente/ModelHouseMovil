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
        title: Text(
          'Create Request',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Color(0XFF02AA8B),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  clipBehavior: Clip.none,
                  child: TextField(
                    controller: categoryController,
                    decoration: InputDecoration(
                      labelText: 'Category',
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),
                SizedBox(height: 14),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  clipBehavior: Clip.none,
                  child: TextField(
                    controller: estimatedBudgetController,
                    decoration: InputDecoration(
                      labelText: 'Estimated Budget',
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),
                SizedBox(height: 14),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  clipBehavior: Clip.none,
                  child: TextField(
                    controller: areaController,
                    decoration: InputDecoration(
                      labelText: 'Area',
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),
                SizedBox(height: 14),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  clipBehavior: Clip.none,
                  child: TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),
                SizedBox(height: 14),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  clipBehavior: Clip.none,
                  child: TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                if (categoryController.text.isNotEmpty &&
                    estimatedBudgetController.text.isNotEmpty &&
                    locationController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  final category = categoryController.text;
                  final estimatedBudget = estimatedBudgetController.text;
                  final location = locationController.text;
                  final description = descriptionController.text;

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
                      // Intenta enviar el request
                      final success = await httpRequest.createRequest(
                          widget.userProfileId,
                          widget.businessProfile.id!,
                          category,
                          estimatedBudget,
                          area,
                          location,
                          description);

                      if (success != null) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Icon(
                              Icons.check,
                              color: Colors.green,
                              size: 64,
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'The request was sent successfully',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Icon(
                            Icons.clear,
                            color: Colors.red,
                            size: 64,
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'Error: The value of area is not a valid number.',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Icon(
                          Icons.clear,
                          color: Colors.red,
                          size: 64,
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Error: The area field cannot be empty.',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Icon(
                        Icons.clear,
                        color: Colors.red,
                        size: 64,
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Validation error: Please fill in all required fields.',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text(
                "Send Request",
                style: TextStyle(fontSize: 15),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF02AA8B),
                minimumSize: Size(200, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
