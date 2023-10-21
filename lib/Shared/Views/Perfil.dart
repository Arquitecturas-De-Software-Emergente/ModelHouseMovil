import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/Account.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/Security/Screens/formUserProfile.dart';

import '../../ServicesManagement/Screens/Profile.dart';

// ignore: must_be_immutable
class Perfil extends StatefulWidget {
  Account account;
  UserProfile userProfile;
  Perfil(this.account, this.userProfile, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.only(bottom: 30),
        child: MaterialButton(
          padding: const EdgeInsets.all(15),
          onPressed: redirectPerfil,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              widget.userProfile.image == null
                  ? const Icon(
                      Icons.person,
                      color: Color(0XFF02AA8B),
                      size: 40,
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(widget.userProfile.image!),
                    ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                      "${widget.userProfile.firstName} ${widget.userProfile.lastName}",
                      style: const TextStyle(
                          color: Color(0XFF02AA8B),
                          fontSize: 19,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(widget.userProfile.phoneNumber,
                      style: const TextStyle(color: Color(0XFF02AA8B)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void redirectPerfil() {
    // ignore: unnecessary_null_comparison
    widget.account != null
        ? Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Profile(widget.userProfile);
              },
            ),
          )
        : Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return FormUserProfile(widget.account);
              },
            ),
          );
  }
}
