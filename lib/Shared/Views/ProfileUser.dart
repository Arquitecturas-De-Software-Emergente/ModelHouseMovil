import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/Shared/Widgets/buttons/ActiveButton.dart';
import 'package:model_house/Shared/Widgets/texts/subtitles.dart';

import '../../Security/Services/User_Profile.dart';
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
  HttpUserProfile? httpUserProfile;

  @override
  void initState() {
    httpUserProfile = HttpUserProfile();
    super.initState();
  }

  void _performProfileUpdate(String firstName, String lastName, String gender,
      String phoneNumber, String address) async {
    if (widget.userProfile.id != null) {
      final updatedProfile = await httpUserProfile?.updateUserProfile(
        firstName,
        lastName,
        gender,
        phoneNumber,
        address,
        widget.userProfile.id!,
      );
      if (updatedProfile != null) {
        setState(() {
          widget.userProfile = updatedProfile;
        });
      } else {
        print("Update fails");
      }
    }
  }

  void _editProfile() {
    String firstName = widget.userProfile.firstName;
    String lastName = widget.userProfile.lastName;
    String gender = widget.userProfile.gender;
    String phoneNumber = widget.userProfile.phoneNumber;
    String? address = widget.userProfile.address;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Update Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: firstName,
                onChanged: (value) {
                  firstName = value;
                },
                decoration: const InputDecoration(labelText: "First Name"),
              ),
              TextFormField(
                initialValue: lastName,
                onChanged: (value) {
                  lastName = value;
                },
                decoration: const InputDecoration(labelText: "Last Name"),
              ),
              TextFormField(
                initialValue: gender,
                onChanged: (value) {
                  gender = value;
                },
                decoration: const InputDecoration(labelText: "Gender"),
              ),
              TextFormField(
                initialValue: phoneNumber,
                onChanged: (value) {
                  phoneNumber = value;
                },
                decoration: const InputDecoration(labelText: "Phone Number"),
              ),
              TextFormField(
                initialValue: address,
                onChanged: (value) {
                  address = value;
                },
                decoration: const InputDecoration(labelText: "Adress"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _performProfileUpdate(
                    firstName, lastName, gender, phoneNumber, address!);
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
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
    final maxDisplayLength = 15;
    final displayValue = value ?? "...";
    final truncatedValue = displayValue.length <= maxDisplayLength
        ? displayValue
        : displayValue.substring(0, maxDisplayLength) + "...";

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              Titles(15, label),
              Subtitles(truncatedValue),
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
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 25),
            child: Row(
              children: [
                Subtitles("Current Plan"),
                const SizedBox(width: 50),
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
