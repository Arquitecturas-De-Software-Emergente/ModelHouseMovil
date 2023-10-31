import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/Account.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/Security/Services/Business_Profile.dart';

import '../../Security/Interfaces/UserProfile.dart';
import '../../Security/Services/Account_Service.dart';
import '../../Security/Services/User_Profile.dart';
import 'Navigation.dart';
import 'Routes.dart';

// ignore: must_be_immutable
class PrincipalView extends StatefulWidget {
  Account account;
  int? index;
  PrincipalView(this.account, this.index, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PrincipalVireState createState() => _PrincipalVireState();
}

class _PrincipalVireState extends State<PrincipalView> {
  int? index;
  Navigation? myNavigation;
  Account? cuenta;
  HttpUserProfile? httpUserProfile;
  HttpBusinessProfile? httpBusinessProfile;
  UserProfile? userProfile;
  BusinessProfile? businessProfile;
  HttpAccount? httpAccount;

  Future signIn() async {
    //cuenta = await httpAccount?.getEmail(widget.account.id.toString());
    setState(() {
      cuenta = cuenta;
    });
  }

  @override
  void initState() {
    httpAccount = HttpAccount();
    httpUserProfile = HttpUserProfile();
    httpBusinessProfile = HttpBusinessProfile();
    setState(() {
      index =  widget.index != null ? widget.index! : 0;
    });
    myNavigation = Navigation(currentIndex: (i) {
      setState(() {
        index = i;
      });
    });
    getUserProfile();
    getBusinessProfile();
    super.initState();
  }

  Future getUserProfile() async {
    userProfile = await httpUserProfile?.getUserProfileById(widget.account.id);
    setState(() {
      userProfile = userProfile;
    });
    print("userProfile: ${userProfile}");
  }

  Future getBusinessProfile() async {
    businessProfile = await httpBusinessProfile
        ?.getbusinessProfileAccountById(widget.account.id);
    setState(() {
      businessProfile = businessProfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: myNavigation,
      body: Routes(index!, widget.account, userProfile, businessProfile),
    );
  }
}
