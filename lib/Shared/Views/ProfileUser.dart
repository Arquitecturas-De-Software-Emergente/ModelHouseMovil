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
  void _editProfile() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: widget.userProfile.firstName,
                decoration: InputDecoration(labelText: "First Name"),
              ),
              TextFormField(
                initialValue: widget.userProfile.lastName,
                decoration: InputDecoration(labelText: "Last Name"),
              ),
              TextFormField(
                initialValue: widget.userProfile.gender,
                decoration: InputDecoration(labelText: "Gender"),
              ),
              TextFormField(
                initialValue: widget.userProfile.phoneNumber,
                decoration: InputDecoration(labelText: "Phone Number"),
              ),
              TextFormField(
                initialValue: widget.userProfile.address,
                decoration: InputDecoration(labelText: "Address"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 30, 40, 30),
          child: Center(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.userProfile.image!),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Column(
                    children: [
                      Subtitles(widget.userProfile.firstName),
                      Subtitles(widget.userProfile.lastName),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Titles(20, "Personal Information"),
              ),
              _buildFieldWithEditButton(
                  "First Name: ", widget.userProfile.firstName),
              _buildFieldWithEditButton(
                  "Last Name: ", widget.userProfile.lastName),
              _buildFieldWithEditButton("Gender: ", widget.userProfile.gender),
              _buildFieldWithEditButton(
                  "Phone Number: ", widget.userProfile.phoneNumber),
              _buildFieldWithEditButton(
                  "Address: ", widget.userProfile.address),
            ],
          ),
        ),
        _buildCurrentPlanSection(),
      ],
    );
  }

  Widget customEditButton(VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          //border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          "EDIT",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildFieldWithEditButton(String label, String? value) {
    final displayValue = value ?? "...";

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              Titles(15, label),
              Subtitles(displayValue),
            ],
          ),
        ),
        customEditButton(() {
          _editProfile();
        }),
      ],
    );
  }

  Widget _buildCurrentPlanSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, top: 25),
            child: Row(
              children: [
                Subtitles("Current Plan"),
                SizedBox(width: 50),
                Subtitles("Basic Plan"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Titles(18, "This is included in your plan"),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.check,
                  color: Color(0xFF02AA8B),
                ),
                Text(" Publish your projects as a company"),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.check,
                  color: Color(0xFF02AA8B),
                ),
                Text(" View your orders"),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.check,
                  color: Color(0xFF02AA8B),
                ),
                Text(" See comments of your projects"),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5, bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.check,
                  color: Color(0xFF02AA8B),
                ),
                Text(" Manage your credit cards"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
