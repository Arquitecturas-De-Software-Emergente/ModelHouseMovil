import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/Security/Interfaces/User.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import '../../Security/Services/Business_Profile.dart';
import '../../Shared/Views/ListBusiness.dart';
import '../../Shared/Widgets/texts/titles.dart';

// ignore: must_be_immutable
class Payment extends StatefulWidget {
  User user;
  UserProfile? userProfile;
  Payment(this.user, this.userProfile, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Payment> {
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
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 15),
            child: Titles(28, "Notification"),
          ),
          businesses != null
              ? ListBusiness(businesses!, widget.userProfile)
              : Container()
        ],
      ),
    );
  }
}
