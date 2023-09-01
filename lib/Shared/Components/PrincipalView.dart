import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/Account.dart';
import 'package:model_house/Security/Interfaces/User.dart';

import '../../Security/Interfaces/UserProfile.dart';
import '../../Security/Services/Account_Service.dart';
import '../../Security/Services/User_Profile.dart';
import 'Navigation.dart';
import 'Routes.dart';

// ignore: must_be_immutable
class PrincipalView extends StatefulWidget {
  User user;
  PrincipalView(this.user, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PrincipalVireState createState() => _PrincipalVireState();
}

class _PrincipalVireState extends State<PrincipalView> {
  int index = 0;
  Navigation? myNavigation;
  Account? cuenta;
  HttpUserProfile? httpUserProfile;
  UserProfile? userProfile;
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
    myNavigation = Navigation(currentIndex: (i) {
      setState(() {
        index = i;
      });
    });
    getUserProfile();
    super.initState();
  }

  Future getUserProfile() async {
    userProfile = await httpUserProfile?.getUserProfileById(widget.user.id);
    setState(() {
      userProfile = userProfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: myNavigation,
      body: Routes(index, widget.user, userProfile),
    );
  }
}
