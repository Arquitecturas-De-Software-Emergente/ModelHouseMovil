import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';

import '../../Security/Interfaces/BusinessProfile.dart';
import '../../Shared/Widgets/texts/titles.dart';
import '../Interfaces/RequestInterface.dart';
import '../Services/Request_Service.dart';

// ignore: must_be_immutable
class RequestCanceled extends StatefulWidget {
  List<RequestInterface>? requests;
  UserProfile? userProfile;
  BusinessProfile? businessProfile;
  RequestCanceled(this.requests, this.userProfile, this.businessProfile,
      {Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RequestCanceledState createState() => _RequestCanceledState();
}

class _RequestCanceledState extends State<RequestCanceled> {
  RequestInterface? request;
  HttpRequest? httpRequest;
  List<RequestInterface>? requestsPending;
  @override
  void initState() {
    httpRequest = HttpRequest();
    print(widget.requests?.length);
    super.initState();
  }

  Future changeStatus(RequestInterface requestInterface, String status) async {
    request = await httpRequest?.changeStatus(requestInterface.id!, status);
    if (request != null) {
      requestsPending = await httpRequest?.getAllUserProfileIdAndStatus(
          widget.userProfile!.id!, "PENDING");
      setState(() {
        request = request;
        widget.requests = requestsPending;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Titles(28, "Model House Options"),
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
          Container(
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: widget.requests?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 200,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            child: Image.network(
                              widget.businessProfile == null
                                  ? widget.userProfile!.image!
                                  : widget.businessProfile!.image,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Align(
                              alignment: Alignment.center,
                              child: Titles(
                                  16, widget.requests![index].description),
                            ),
                          ),
                          widget.businessProfile != null
                              ? Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(
                                                  0.5), // Color de la sombra
                                              spreadRadius:
                                                  2, // Radio de expansión de la sombra
                                              blurRadius:
                                                  5, // Radio de desenfoque de la sombra
                                              offset: Offset(0,
                                                  3), // Desplazamiento en la posición x y y de la sombra
                                            ),
                                          ],
                                        ),
                                        child: MaterialButton(
                                            color: const Color(0xFF1FB440),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            minWidth: 120,
                                            height: 50,
                                            onPressed: () {
                                              changeStatus(
                                                  widget.requests![index],
                                                  "PENDING_PROPOSAL");
                                            },
                                            child: const Text(
                                              "Accept",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white),
                                            )),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(
                                                  0.5), // Color de la sombra
                                              spreadRadius:
                                                  2, // Radio de expansión de la sombra
                                              blurRadius:
                                                  5, // Radio de desenfoque de la sombra
                                              offset: Offset(0,
                                                  3), // Desplazamiento en la posición x y y de la sombra
                                            ),
                                          ],
                                        ),
                                        child: MaterialButton(
                                            color: const Color(0xFFDF3737),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            minWidth: 120,
                                            height: 50,
                                            onPressed: () {
                                              changeStatus(
                                                  widget.requests![index],
                                                  "CANCELED");
                                            },
                                            child: const Text("Reject",
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white))),
                                      ),
                                    ],
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
