import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/ServicesManagement/Interfaces/RequestInterface.dart';
import 'package:model_house/ServicesManagement/Screens/BusinessProfileContent.dart';
import 'package:model_house/ServicesManagement/Screens/Home.dart';
import 'package:model_house/ServicesManagement/Services/Request_Service.dart';
import 'package:model_house/Shared/Components/PrincipalView.dart';
import 'package:uuid/uuid.dart';

import '../../Security/Interfaces/Account.dart';
import '../../Security/Interfaces/UserProfile.dart';
import '../../Security/Services/User_Profile.dart';
import '../../Shared/DialogModelHouse.dart';
import 'package:http/http.dart' as http;
class Place {
  final String placeId;
  final String description;

  Place(this.placeId, this.description);

  @override
  String toString() {
    return 'Place(description: $description, placeId: $placeId)';
  }
}
class CreateRequest extends StatefulWidget {
  BusinessProfile businessProfile;
  String userProfileId;
  Account account;
  CreateRequest(this.businessProfile, this.userProfileId, this.account, {super.key});
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
  final apiKey = 'AIzaSyAUkXe3mWmqdi9LbB_dFVHcZ7-wLjZbxao'; // Reemplaza con tu clave de API de Google Places
  final sessionToken = Uuid().v4();
  List<Place> _suggestions = [];
  Timer? _debounce; // Para retrasar la llamada a fetchSuggestions

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  void fetchSuggestions(String input) async {
    final request = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${input}&key=$apiKey&sessiontoken=$sessionToken&components=country:PE');
    final response = await http.get(request);
    print(response.body);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        setState(() {
          _suggestions = (result['predictions'] as List)
              .map((prediction) => Place(
              prediction['place_id'] as String,
              prediction['description'] as String))
              .toList();
        });
      } else {
        setState(() {
          _suggestions = [];
        });
      }
    } else {
      throw Exception('Failed to fetch suggestions');
    }
  }

  void onTextChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      // Llama fetchSuggestions después de un retraso de 500 ms
      fetchSuggestions(text);
    });
  }

  Future iniState() async {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> estimatedBudgetOptions = [
      'Less than 1000 soles',
      'Between 1000 and 3000 soles',
      'Between 3000 and 5000 soles',
      'More than 5000 soles',
    ];
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
                  child: DropdownButton<String>(
                    value: estimatedBudgetOptions.contains(estimatedBudgetController.text)
                        ? estimatedBudgetController.text
                        : estimatedBudgetOptions[0],
                    onChanged: (String? newValue) {
                      setState(() {
                        estimatedBudgetController.text = newValue ?? '';
                      });
                    },
                    items: estimatedBudgetOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(option),
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    underline: Container(), // Para ocultar la línea bajo el desplegable
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
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
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
                  child: Column(
                    children: [
                      TextField(
                        controller: locationController,
                        onChanged: onTextChanged,
                        decoration: InputDecoration(
                          labelText: 'Location',
                          contentPadding: EdgeInsets.all(16),
                        ),
                      ),
                      if (_suggestions.isNotEmpty)
                        Column(
                          children: _suggestions
                              .map((suggestion) => ListTile(
                            title: Text(suggestion.description),
                            onTap: () {
                              setState(() {
                                locationController.text = suggestion.description;
                                _suggestions = [];
                              });
                            },
                          ))
                              .toList(),
                        )
                    ],
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
                        showCustomDialog(context, "Success", "The request was sent successfully", true, PrincipalView(widget.account, 0));
                      }
                    } else {
                      showCustomDialog(context, "Error", "The value of area is not a valid number.", false, PrincipalView(widget.account, 0));
                    }
                  } else {
                    showCustomDialog(context, "Error", "The area field cannot be empty", false, PrincipalView(widget.account, 0));
                  }
                } else {
                  showCustomDialog(context, "Validation error", "Please fill in all required fields.", false, PrincipalView(widget.account, 0));
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
