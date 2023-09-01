import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/Account.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/Security/Services/Business_Profile.dart';

import '../Widgets/buttons/ActiveButton.dart';
import '../Widgets/buttons/Input.dart';
import '../Widgets/texts/titles.dart';

class FormProfileBusines extends StatefulWidget {
  Account account;
  FormProfileBusines(this.account, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FormProfileBusinesState createState() => _FormProfileBusinesState();
}

class _FormProfileBusinesState extends State<FormProfileBusines> {
  final name = TextEditingController();
  final address = TextEditingController();
  final description = TextEditingController(text: "Gender");
  final phoneBusiness = TextEditingController();
  final image = TextEditingController();
  final webSite = TextEditingController();
  List<String> genderOptions = ['Gender', 'Male', 'Female'];
  HttpBusinessProfile? httpBusinessProfile;
  BusinessProfile businessProfile = BusinessProfile(
      address: "",
      description: "",
      image: "",
      name: "",
      phoneBusiness: "",
      webSite: "");
  BusinessProfile? response;

  @override
  void initState() {
    httpBusinessProfile = HttpBusinessProfile();
    super.initState();
  }

  Future initialize() async {
    businessProfile.name = name.text;
    businessProfile.address = address.text;
    businessProfile.description = description.text;
    businessProfile.image = image.text;
    businessProfile.phoneBusiness = phoneBusiness.text;
    businessProfile.webSite = webSite.text;
    response = await httpBusinessProfile?.createProfile(
        businessProfile, widget.account.id);
    setState(() {
      response = response;
      if (response != null) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title:
                    const Text("The business profile was created successfully"),
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
                        name.text = "";
                        address.text = "";
                        description.text = "";
                        phoneBusiness.text = "";
                        webSite.text = "";
                        image.text = "";
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
        title: Titles(33, "Business Profile"),
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
                    child: Input(Icons.abc, "Insert Name", false, name, false,
                        TextInputType.text),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Input(Icons.abc, "Insert Address", false, address,
                        false, TextInputType.text),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Input(Icons.abc, "Insert Description", false,
                        description, false, TextInputType.number),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Input(Icons.abc, "Insert your Phone Business", false,
                        phoneBusiness, false, TextInputType.text),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Input(Icons.abc, "Insert your Web Site", false,
                        webSite, false, TextInputType.text),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Input(Icons.abc, "Insert your Image", false, image,
                        false, TextInputType.text),
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      child: ActiveButton(
                          12, "Update Business Profile", initialize, 18))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
