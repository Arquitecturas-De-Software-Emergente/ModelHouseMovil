import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/Account.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/Security/Interfaces/User.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/Security/Screens/welcomeApplication.dart';
import 'package:model_house/Security/Services/Account_Service.dart';
import 'package:model_house/Security/Services/Business_Profile.dart';
import 'package:model_house/Shared/Views/FormBusinessProfile.dart';
import 'package:model_house/Shared/Views/FormProfileUser.dart';
import 'package:model_house/Shared/Views/PerfilBusiness.dart';
import 'package:model_house/Shared/Widgets/buttons/ActiveButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Shared/Views/Activities.dart';
import '../../Shared/Views/Adicional.dart';
import '../../Shared/Views/Perfil.dart';

// ignore: must_be_immutable
class Menu extends StatefulWidget {
  int? idAccount;
  String? role;
  UserProfile? userProfile;
  Menu(this.idAccount, this.role, this.userProfile, {Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  HttpBusinessProfile? httpBusinessProfile;
  HttpAccount? httpAccount;
  Account? account;
  BusinessProfile? businessProfile;
  String? token;
  @override
  void initState() {
    httpBusinessProfile = HttpBusinessProfile();
    httpAccount = HttpAccount();
    if (widget.role == "business") {
      activeBusiness();
    }
    super.initState();
  }

  Future activeBusiness() async {
    account = await httpAccount?.getAccountByUserId(widget.idAccount);
    if (account != null) {
      setState(() {
        account = account;
      });
      getBusiness();
    }
  }

  Future getBusiness() async {
    businessProfile =
        await httpBusinessProfile?.getbusinessProfileAccountById(account!.id);
    if (businessProfile != null) {
      setState(() {
        businessProfile = businessProfile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(25), // Margen general alrededor del contenedor
          child: const Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('../images/profile.png'),
              ),
              SizedBox(width: 30),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Username',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: const [
              Activities(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
                child: Adicional(),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(15), // Agrega el margen que desees
          child: MaterialButton(
            height: 45,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: const Color(0XFF02AA8B),
            onPressed: () async {
              final persitence = await SharedPreferences.getInstance();
              persitence.remove("token");
              // ignore: use_build_context_synchronously
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const WelcomeApplication();
                  },
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
              child: const Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                    child: Icon(
                      Icons.logout_outlined,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Log Out",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
