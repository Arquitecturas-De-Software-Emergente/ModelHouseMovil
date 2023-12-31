import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/Security/Interfaces/Proyect.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/Security/Services/Proyect_Service.dart';
import 'package:model_house/ServicesManagement/Interfaces/RequestInterface.dart';
import 'package:model_house/ServicesManagement/Services/Request_Service.dart';
import 'package:model_house/Shared/Widgets/buttons/ActiveButton.dart';

import '../../Shared/Widgets/texts/titles.dart';

// ignore: must_be_immutable
class BusinessContent extends StatefulWidget {
  BusinessProfile businessProfile;
  UserProfile? userProfile;
  BusinessContent(this.businessProfile, this.userProfile, {Key? key})
      : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _BusinessContentState createState() => _BusinessContentState();
}

class _BusinessContentState extends State<BusinessContent> {
  HttpProyect? httpProyect;
  RequestInterface? request;
  HttpRequest? httpRequest;
  List<Proyect>? proyects;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController description = TextEditingController();

  @override
  void initState() {
    httpProyect = HttpProyect();
    httpRequest = HttpRequest();
    getBusiness();
    super.initState();
  }

  Future getBusiness() async {
    proyects =
        await httpProyect?.getAllByBusinessId(widget.businessProfile.id!);
    setState(() {
      proyects = proyects;
    });
  }

  Future emitRequest() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Formulario'),
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: description,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your description';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text('Guardar'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    request = await httpRequest?.createRequest(
                        widget.userProfile!.id!,
                        widget.businessProfile.id!,
                        "PENDING",
                        description.text,
                        false);
                    setState(() {
                      if (request != null) {
                        request = request;
                        const snackBar = SnackBar(
                          content: Text('A request was created successfully'),
                          duration: Duration(seconds: 2),
                          backgroundColor: Color(0xFF7EDA3E),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        const snackBar = SnackBar(
                            content:
                                Text('A request was not created successfully'),
                            duration: Duration(seconds: 2),
                            backgroundColor:
                                // ignore: use_full_hex_values_for_flutter_colors
                                Color(0xff7da4a3e));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Titles(28, "Business Profile"),
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
      body: Container(
        padding: const EdgeInsets.all(0),
        child: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              height: 200,
              child: Image.network(
                widget.businessProfile.image!,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Container(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 7, left: 15, right: 15),
                  child: Titles(20, widget.businessProfile.name)),
            ),
            Container(
                padding: const EdgeInsets.only(
                    top: 7, bottom: 7, left: 15, right: 15),
                child: Text(widget.businessProfile.description)),
            Container(
                padding: const EdgeInsets.only(
                    top: 7, bottom: 7, left: 15, right: 15),
                child: Text(widget.businessProfile.address)),
            Container(
                padding: const EdgeInsets.only(
                    top: 7, bottom: 7, left: 15, right: 15),
                child: Text(widget.businessProfile.phoneNumber)),
            Container(
                padding: const EdgeInsets.only(
                    top: 7, bottom: 7, left: 15, right: 15),
                child: Text(widget.businessProfile.webSite)),
            proyects != null
                ? Padding(
                    padding: const EdgeInsets.all(15),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: proyects?.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                proyects![index].image,
                                fit: BoxFit.cover,
                              ),
                            ));
                      },
                    ),
                  )
                : Container(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45,
              margin: const EdgeInsets.all(15),
              child: ActiveButton(10, "Request", emitRequest, 18),
            )
          ],
        ),
      ),
    );
  }
}
