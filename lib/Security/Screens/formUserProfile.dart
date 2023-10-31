import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/Security/Services/User_Profile.dart';

import '../../Shared/Components/PrincipalView.dart';
import '../../Shared/Widgets/buttons/ActiveButton.dart';
import '../../Shared/Widgets/buttons/Input.dart';
import '../../Shared/Widgets/texts/titles.dart';
import '../Interfaces/Account.dart';
import '../Services/Account_Service.dart';

class FormUserProfile extends StatefulWidget {
  Account account;
  FormUserProfile(this.account, {super.key});

  @override
  State<FormUserProfile> createState() => _FormUserProfileState();
}

class _FormUserProfileState extends State<FormUserProfile> {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final gender = TextEditingController(text: "Gender");
  final phoneNumber = TextEditingController();
  final address = TextEditingController();
  List<String> genderOptions = ['Gender', 'Male', 'Female'];
  File? _image;
  UserProfile? userProfile;
  HttpUserProfile? httpUserProfile;
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final PickedFile? pickedImage = await _picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }
  void initState() {
    httpUserProfile = HttpUserProfile();
    super.initState();
  }
  Future signUp() async {
    if(_image != null && firstName.text != "" && lastName.text != ""
        && phoneNumber.text != "" && address.text != ""){
      userProfile = await httpUserProfile?.createProfile(widget.account.id!, phoneNumber.text, firstName.text,
          lastName.text, gender.text, address.text);
      setState(() async {
        userProfile = userProfile;
        if(userProfile != null){
          bool? upload = await httpUserProfile?.uploadFile(_image!, userProfile!.id!);
          setState(() async {
            upload = upload;
            if(upload == true){
              widget.account.userProfileId = userProfile?.id.toString();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return PrincipalView(widget.account, null);
                  },
                ),
              );
            }
          });
        }
      });
    }else{
      const snackBar = SnackBar(
          content: Text('Complete all fields'),
          duration: Duration(seconds: 2),
          // ignore: use_full_hex_values_for_flutter_colors
          backgroundColor: Color(0xff7da4a3e));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Titles(28, "Form User Profile"),
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
              child: Center(
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
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Input(Icons.abc, "First name", false,
                        firstName, false, TextInputType.text),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Input(Icons.abc, "Last name", false,
                        lastName, false, TextInputType.text),
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
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0XFF02AA8B),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        gender.text = newValue!;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Input(Icons.abc, "Phone number", false,
                        phoneNumber, false, TextInputType.number),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Input(Icons.abc, "Address", false,
                        address, false, TextInputType.text),
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: ActiveButton(25, "Sign Up", signUp, 19)
            )
          ],
        ),
      ),
    );
  }
}
