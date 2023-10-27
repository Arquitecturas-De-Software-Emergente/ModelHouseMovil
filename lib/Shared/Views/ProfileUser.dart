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
  String? firstName;
  String? lastName;
  String? gender;
  String? phoneNumber;
  String? address;

  @override
  void initState() {
    httpUserProfile = HttpUserProfile();
    super.initState();
  }

  void _performProfileUpdate() async {
    if (widget.userProfile.id != null &&
        firstName != null &&
        lastName != null &&
        gender != null &&
        phoneNumber != null) {
      final updatedProfile = await httpUserProfile?.updateUserProfile(
        firstName!,
        lastName!,
        gender!,
        phoneNumber!,
        address ?? '',
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

  Widget _buildEditButton() {
    return ElevatedButton(
      onPressed: () {
        _editProfile();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0XFF02AA8B),
      ),
      child: Text("EDIT", style: TextStyle(color: Colors.white)),
    );
  }

  void _editProfile() {
    firstName = widget.userProfile.firstName;
    lastName = widget.userProfile.lastName;
    gender = widget.userProfile.gender;
    phoneNumber = widget.userProfile.phoneNumber;
    address = widget.userProfile.address;

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
                  setState(() {
                    firstName = value;
                  });
                },
                decoration: const InputDecoration(labelText: "First Name"),
              ),
              TextFormField(
                initialValue: lastName,
                onChanged: (value) {
                  setState(() {
                    lastName = value;
                  });
                },
                decoration: const InputDecoration(labelText: "Last Name"),
              ),
              TextFormField(
                initialValue: gender,
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
                decoration: const InputDecoration(labelText: "Gender"),
              ),
              TextFormField(
                initialValue: phoneNumber,
                onChanged: (value) {
                  setState(() {
                    phoneNumber = value;
                  });
                },
                decoration: const InputDecoration(labelText: "Phone Number"),
              ),
              TextFormField(
                initialValue: address,
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
                decoration: const InputDecoration(labelText: "Adress"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _performProfileUpdate();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Titles(20, "Personal Information"),
                  _buildEditButton(),
                ],
              ),
              _buildField("First Name: ", widget.userProfile.firstName),
              _buildField("Last Name: ", widget.userProfile.lastName),
              _buildField("Gender: ", widget.userProfile.gender),
              _buildField("Phone Number: ", widget.userProfile.phoneNumber),
              _buildField("Address: ", widget.userProfile.address),
            ],
          ),
        ),
        _buildCurrentPlanSection(),
      ],
    );
  }

  Widget _buildField(String label, String? value) {
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
            padding: const EdgeInsets.only(left: 20, top: 20),
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
          Padding(
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
          Padding(
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
          Padding(
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
          Padding(
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
