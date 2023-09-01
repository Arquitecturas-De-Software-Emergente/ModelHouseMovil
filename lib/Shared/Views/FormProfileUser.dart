import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/User.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/Shared/Widgets/buttons/ActiveButton.dart';
import 'package:model_house/Shared/Widgets/buttons/Input.dart';

import '../../Security/Services/User_Profile.dart';
import '../Widgets/texts/titles.dart';

// ignore: must_be_immutable
class FormProfileUser extends StatefulWidget {
  User user;
  FormProfileUser(this.user, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FormProfileUserState createState() => _FormProfileUserState();
}

class _FormProfileUserState extends State<FormProfileUser> {
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final gender = TextEditingController(text: "Gender");
  final phonenumber = TextEditingController();
  final image = TextEditingController();
  List<String> genderOptions = ['Gender', 'Male', 'Female'];
  HttpUserProfile? httpUserProfile;
  UserProfile profile =
      UserProfile(firstName: '', gender: '', lastName: '', phoneNumber: '');
  UserProfile? response;

  @override
  void initState() {
    httpUserProfile = HttpUserProfile();
    super.initState();
  }

  Future initialize() async {
    profile.firstName = firstname.text;
    profile.lastName = firstname.text;
    profile.gender = gender.text;
    profile.phoneNumber = phonenumber.text;
    profile.image = image.text;
    response = await httpUserProfile?.createProfile(widget.user.id, profile);
    setState(() {
      response = response;
      if (response != null) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("The post was created successfully"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"))
                ],
              );
            });
      } else {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Something went wrong"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        firstname.text = "";
                        lastname.text = "";
                        gender.text = "";
                        phonenumber.text = "";
                      },
                      child: const Text("Ok"))
                ],
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Titles(33, "Profile"),
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
      body: ListView(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Input(Icons.abc, "Insert First Name", false,
                        firstname, false, TextInputType.text),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Input(Icons.abc, "Insert Last Name", false, lastname,
                        false, TextInputType.text),
                  ),
                  DropdownButton<String>(
                    value: gender.text,
                    items: genderOptions
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color(0XFF02AA8B),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    // Step 5.
                    onChanged: (String? newValue) {
                      setState(() {
                        gender.text = newValue!;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Input(Icons.abc, "Insert Phone Number", false,
                        phonenumber, false, TextInputType.number),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Input(Icons.abc, "Insert your image URL", false,
                        image, false, TextInputType.text),
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: ActiveButton(12, "Update Profile", initialize, 18))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
