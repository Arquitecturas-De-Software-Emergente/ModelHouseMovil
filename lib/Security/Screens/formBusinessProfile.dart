import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/Security/Services/Business_Profile.dart';

import '../../Shared/Components/PrincipalView.dart';
import '../../Shared/Widgets/buttons/ActiveButton.dart';
import '../../Shared/Widgets/buttons/Input.dart';
import '../../Shared/Widgets/texts/titles.dart';
import '../Interfaces/Account.dart';
import '../Interfaces/UserProfile.dart';
import '../Services/Account_Service.dart';
import '../Services/User_Profile.dart';

class FormBusinessProfile extends StatefulWidget {
  Account account;
  FormBusinessProfile(this.account, {super.key});

  @override
  State<FormBusinessProfile> createState() => _FormBusinessProfileState();
}

class _FormBusinessProfileState extends State<FormBusinessProfile> {
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final webSite = TextEditingController();
  final address = TextEditingController();
  final foundationDate = TextEditingController();
  final description = TextEditingController();
  List<String> genderOptions = ['Gender', 'Male', 'Female'];
  File? _image;
  BusinessProfile? businessProfile;
  HttpBusinessProfile? httpBusinessProfile;
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final PickedFile? pickedImage =
        await _picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void initState() {
    httpBusinessProfile = HttpBusinessProfile();
    super.initState();
  }

  Future signUp() async {
    if (_image != null &&
        name.text != "" &&
        description.text != "" &&
        phoneNumber.text != "" &&
        address.text != "" &&
        webSite.text != "") {
      businessProfile = await httpBusinessProfile?.createProfile(
          name.text,
          description.text,
          address.text,
          phoneNumber.text,
          webSite.text,
          widget.account.id!);
      setState(() async {
        businessProfile = businessProfile;

        if (businessProfile != null) {
          bool? upload = await httpBusinessProfile?.uploadFile(
              _image!, businessProfile!.id!);
          setState(() async {
            upload = upload;
            if (upload == true) {
              widget.account.businessProfileId = businessProfile?.id.toString();
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
    } else {
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
        title: Titles(28, "Form Business Profile"),
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
                child: _image == null
                    ? ElevatedButton(
                        onPressed: _pickImage,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: const Icon(Icons.person_4_outlined,
                            color: Colors.black, size: 75),
                      )
                    : Image.file(
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
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Input(Icons.abc, "Name", false, name, false,
                        TextInputType.text),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Input(Icons.abc, "Phone Number", false, phoneNumber,
                        false, TextInputType.text),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Input(Icons.abc, "Web Site", false, webSite, false,
                        TextInputType.text),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Input(Icons.abc, "Address", false, address, false,
                        TextInputType.text),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                    child: Input(Icons.abc, "Description", false, description,
                        false, TextInputType.number),
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: ActiveButton(25, "Sign Up", signUp, 19))
          ],
        ),
      ),
    );
    ;
  }
}
