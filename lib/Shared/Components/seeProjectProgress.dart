import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:model_house/Shared/DialogModelHouse.dart';
import 'package:model_house/Shared/Widgets/texts/titles.dart';

import '../../Security/Interfaces/Account.dart';
import '../../Security/Interfaces/BusinessProfile.dart';
import '../../Security/Interfaces/UserProfile.dart';
import '../../ServicesManagement/Interfaces/ProjectInterface.dart';
import '../../ServicesManagement/Interfaces/Proposal.dart';
import '../../ServicesManagement/Services/Project_Service.dart';
import 'PrincipalView.dart';

class SeeProjectProgress extends StatefulWidget {
  Account? account;
  final ProjectInterface project;
  UserProfile? userProfile;
  BusinessProfile? businessProfile;

  SeeProjectProgress(this.account, this.project, this.userProfile, this.businessProfile);

  @override
  State<SeeProjectProgress> createState() => _SeeProjectProgressState();
}

class _SeeProjectProgressState extends State<SeeProjectProgress> {
  late TextEditingController titleController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();
  late TextEditingController activityTitleController = TextEditingController();
  late TextEditingController resourceTitleController = TextEditingController();
  late TextEditingController resourceQuantityController = TextEditingController();
  List<Map<String, dynamic>> activities = [];
  List<Map<String, dynamic>> resources = [];
  HttpProject? httpProject;

  @override
  void initState() {
    super.initState();
    httpProject = HttpProject();
    titleController = TextEditingController(text: widget.project.title);
    descriptionController = TextEditingController(text: widget.project.description);
    getActivityList();
    getResourceList();
  }

  void getActivityList() {
    if (widget.project.projectActivities != null) {
      activities = widget.project.projectActivities!;
    }
  }

  void getResourceList() {
    if (widget.project.projectResources != null) {
      resources = widget.project.projectResources!;
    }
  }

  void addActivity() {
    String title = activityTitleController.text;
    if (title.isNotEmpty) {
      // Agregar la nueva actividad a la lista
      activities.add({
        "description": title,
        "isChecked": false,
      });
      // Limpia el campo de texto después de agregar la actividad
      activityTitleController.clear();
      setState(() {}); // Actualiza la UI para mostrar la nueva actividad
    }
  }

  void deleteActivity(int index) {
    setState(() {
      activities.removeAt(index);
    });
  }

  void addResource() {
    String title = resourceTitleController.text;
    String quantity = resourceQuantityController.text;

    if (title.isNotEmpty && quantity.isNotEmpty) {
      // Agregar el nuevo recurso a la lista
      resources.add({
        "description": title,
        "quantity": quantity,
        "isChecked": false,
      });

      // Limpia los campos de texto después de agregar el recurso
      resourceTitleController.clear();
      resourceQuantityController.clear();

      setState(() {}); // Actualiza la UI para mostrar el nuevo recurso
    }
  }

  void deleteResource(int index) {
    setState(() {
      resources.removeAt(index);
    });
  }

  double calculateProgress(List<Map<String, dynamic>> items) {
    final checkedItems = items.where((item) => item["isChecked"] == true).toList();
    return (checkedItems.length / items.length) * 100;
  }

  void validateAndSubmit(
      List<Map<String, dynamic>> activities, List<Map<String, dynamic>> resources) {
    String title = titleController.text;
    String description = descriptionController.text;

    print('Title: $title');
    print('Description: $description');
    print('Number of Activities: ${activities.length}');
    print('Number of Resources: ${resources.length}');

    double generalProgress = calculateProgress(activities + resources);
    double activityProgress = calculateProgress(activities);
    double resourceProgress = calculateProgress(resources);

    print('General Progress: $generalProgress%');
    print('Activity Progress: $activityProgress%');
    print('Resource Progress: $resourceProgress%');

    // Actualiza el proyecto
    var projectValue = httpProject?.updateProject(
      widget.project.id ?? 0,
      title,
      description,
      activities,
      resources,
    );
    setState(() {
      projectValue = projectValue;
    });
    if (projectValue != null) {
      showCustomDialog(context, "Success", "The request was sent successfully", true, PrincipalView(widget.account!, 1));
    } else {
      showCustomDialog(context, "Error", "Error sending request", false, PrincipalView(widget.account!, 1));
    }
  }
  void finishTheProject(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Are you sure you want to submit your project?"),
          actions: <Widget>[
            TextButton(
              child: Text("Go Back"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Continue"),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo de confirmación
                performFinishProject(); // Llama a la función para finalizar el proyecto
              },
            ),
          ],
        );
      },
    );
  }

  void performFinishProject() {
    var projectValue = httpProject?.finishProject(widget.project.id!, "Completado");
    setState(() {
      projectValue = projectValue;
    });
    if (projectValue != null) {
      showCustomDialog(context, "Success", "The project was completed successfully", true, PrincipalView(widget.account!, 1));
    } else {
      showCustomDialog(context, "Error", "An error occurred in your project", false, PrincipalView(widget.account!, 1));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Titles(28, 'Project Progress'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Progress Indicator
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: Column(
                children: [
                  Text(
                    "Total Progress ${((calculateProgress(activities) + calculateProgress(resources)) / 2).toStringAsFixed(2)}%",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  LinearProgressIndicator(
                    value: calculateProgress(activities + resources) / 100,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ],
              ),
            ),
            // Title
            if (widget.businessProfile != null)
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
            if (widget.userProfile != null) Text("Title: ", style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),),
            if (widget.userProfile != null) Text("${widget.project.title}"),
            SizedBox(height: 12.0),

            // Description
            if (widget.businessProfile != null)
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            if (widget.userProfile != null) Text("Description: ", style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),),
            if (widget.userProfile != null) Text("${widget.project.description}"),
            SizedBox(height: 12.0),

            // Activities Progress Indicator
            Text(
              "Activity Progress: ${calculateProgress(activities).toStringAsFixed(2)}%",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            LinearProgressIndicator(
              value: calculateProgress(activities) / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 20),

            // Activities
            Text(
              "Activities",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            if (widget.businessProfile != null)
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: activityTitleController,
                      decoration: InputDecoration(labelText: 'Activity Title'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.green),
                    onPressed: addActivity,
                  ),
                ],
              ),
            Column(
              children: activities.asMap().entries.map((entry) {
                final index = entry.key;
                final activity = entry.value;
                return Row(
                  children: [
                    if (widget.businessProfile != null)
                      Checkbox(
                        value: activity["isChecked"] ?? false,
                        onChanged: (bool? newValue) {
                          setState(() {
                            activity["isChecked"] = newValue;
                          });
                        },
                      ),
                    if (widget.userProfile != null)
                      Icon(
                        activity["isChecked"] == true ? Icons.check : Icons.crop_square,
                        size: 30.0,
                        color: activity["isChecked"] == true ? Colors.green : Colors.blue,
                      ),
                    SizedBox(width: 8),
                    Text(activity["description"].toString()),
                    if (widget.businessProfile != null)
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteActivity(index),
                      ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 12.0),

            // Resources Progress Indicator
            Text(
              "Resource Progress: ${calculateProgress(resources).toStringAsFixed(2)}%",
              style: TextStyle(
                color: Colors.orange,
              ),
            ),
            LinearProgressIndicator(
              value: calculateProgress(resources) / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
            SizedBox(height: 20),

            // Resources
            Text(
              "Resources",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            if (widget.businessProfile != null)
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: resourceTitleController,
                      decoration: InputDecoration(labelText: 'Resource Title'),
                    ),
                  ),
                  Flexible(
                    child: TextField(
                      controller: resourceQuantityController,
                      decoration: InputDecoration(labelText: 'Quantity'),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.green),
                    onPressed: addResource,
                  ),
                ],
              ),
            Column(
              children: resources.asMap().entries.map((entry) {
                final index = entry.key;
                final resource = entry.value;
                return Row(
                  children: [
                    if (widget.businessProfile != null)
                      Checkbox(
                        value: resource["isChecked"] ?? false,
                        onChanged: (bool? newValue) {
                          setState(() {
                            resource["isChecked"] = newValue;
                          });
                        },
                      ),
                    if (widget.userProfile != null)
                      Icon(
                        resource["isChecked"] == true ? Icons.check : Icons.crop_square,
                        size: 30.0,
                        color: resource["isChecked"] == true ? Colors.green : Colors.blue,
                      ),
                    Expanded(
                      child: Text('Resource: ${resource["description"]}, Quantity: ${resource["quantity"]}'),
                    ),
                    if (widget.businessProfile != null)
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteResource(index),
                      ),
                  ],
                );
              }).toList(),
            ),

            // Save Progress Button
            if (widget.businessProfile != null &&((calculateProgress(activities) + calculateProgress(resources)) / 2).toStringAsFixed(2) != "100.00")
              ElevatedButton(
                onPressed: () {
                  validateAndSubmit(activities, resources);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                ),
                child: Text("Save Progress"),
              ),
            if (widget.businessProfile != null && ((calculateProgress(activities) + calculateProgress(resources)) / 2).toStringAsFixed(2) == "100.00")
              ElevatedButton(
                onPressed: () {
                    finishTheProject(context);
                  },
                  style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                ),
                child: Text("Finish Project"),
              ),
          ],
        ),
      ),
    );
  }
}

