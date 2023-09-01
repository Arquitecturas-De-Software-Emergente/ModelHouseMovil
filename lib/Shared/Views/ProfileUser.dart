import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/Shared/Widgets/buttons/ActiveButton.dart';
import 'package:model_house/Shared/Widgets/texts/subtitles.dart';

import '../Widgets/texts/titles.dart';

// ignore: must_be_immutable
class ProfileUser extends StatefulWidget {
  UserProfile userProfile;
  ProfileUser(this.userProfile, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileUserState createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 30, 40, 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.userProfile.image!),
              ),
              Column(
                children: [
                  Subtitles(widget.userProfile.firstName),
                  Container(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Subtitles(widget.userProfile.lastName)),
                  ActiveButton(8, "Edit Profile", () {}, 18)
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Titles(23, "Personal Information"),
              ),
              Center(
                child: Container(
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: Column(
                        children: [
                          Titles(20, "Gender: "),
                          Subtitles(widget.userProfile.gender),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: Column(
                        children: [
                          Titles(20, "Phone Number: "),
                          Subtitles(widget.userProfile.phoneNumber)
                        ],
                      ),
                    ),
                  ]),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
