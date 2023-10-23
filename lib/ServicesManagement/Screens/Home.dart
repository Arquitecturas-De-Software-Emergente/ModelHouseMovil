import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/Shared/Components/businessProfile_card.dart';
import 'package:model_house/Shared/Views/ListBusiness.dart';
import 'package:model_house/Shared/Widgets/buttons/Input.dart';
import 'package:model_house/Shared/Widgets/texts/titles.dart';

import '../../Security/Services/Business_Profile.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  UserProfile? userProfile;
  Home(this.userProfile, {Key? key}) : super(key: key);

  @override
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
            child: Input(Icons.search, "Search on Model House", true, algo, false, TextInputType.text),
          ),
          businesses != null
              ? Expanded(
                  child: ListView.builder(
                    itemCount: businesses!.length,
                    itemBuilder: (context, index) {
                      final business = businesses![index];
                      return BusinessProfileCard(
                        id: business.id!,
                        address: business.address,
                        description: business.description,
                        image: business.image!,
                        name: business.name,
                        phoneNumber: business.phoneNumber,
                        webSite: business.webSite,
                      );
                    },
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
