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
  User user;
  UserProfile? userProfile;
  Menu(this.user, this.userProfile, {Key? key}) : super(key: key);

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
    if (widget.user.role == "business") {
      activeBusiness();
    }
    super.initState();
  }

  Future activeBusiness() async {
    account = await httpAccount?.getAccountByUserId(widget.user.id);
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
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        widget.userProfile != null
            ? Perfil(widget.user, widget.userProfile!)
            : Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 20, 10),
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: ActiveButton(12, "Create Business Profile", () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return FormProfileUser(widget.user);
                      },
                    ),
                  );
                }, 18),
              ),
        widget.user.role == "business" && businessProfile != null
            ? PerfilBusiness(account!, businessProfile!)
            : Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 20, 10),
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: ActiveButton(12, "Create Business Profile", () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return FormProfileBusines(account!);
                      },
                    ),
                  );
                }, 18),
              ),
        const Activities(),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
          child: Adicional(),
        ),
        MaterialButton(
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
            child: Row(children: const <Widget>[
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
              )
            ]),
          ),
        ),
      ],
    );
  }
}
