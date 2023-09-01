import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/Security/Interfaces/User.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/Shared/Views/ListBusiness.dart';
import 'package:model_house/Shared/Widgets/buttons/Input.dart';
import 'package:model_house/Shared/Widgets/texts/titles.dart';

import '../../Security/Services/Business_Profile.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  User user;
  UserProfile? userProfile;
  Home(this.user, this.userProfile, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final algo = TextEditingController();
  HttpBusinessProfile? httpBusinessProfile;
  List<BusinessProfile>? businesses;
  @override
  void initState() {
    httpBusinessProfile = HttpBusinessProfile();
    getBusiness();
    super.initState();
  }

  Future getBusiness() async {
    businesses = await httpBusinessProfile?.getAllBusinessProfile();
    setState(() {
      businesses = businesses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 15),
            child: Titles(32, "Home"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: Input(Icons.search, "Search on Model House", true, algo,
                false, TextInputType.text),
          ),
          businesses != null
              ? ListBusiness(businesses!, widget.userProfile)
              : Container()
        ],
      ),
    );
  }
}
