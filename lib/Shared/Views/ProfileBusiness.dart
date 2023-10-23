import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/Shared/Widgets/buttons/ActiveButton.dart';
import 'package:model_house/Shared/Widgets/texts/titles.dart';
import 'package:model_house/Shared/Widgets/texts/subtitles.dart';

class ProfileBusiness extends StatefulWidget {
  BusinessProfile businessProfile;
  ProfileBusiness(this.businessProfile, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileBusinessState createState() => _ProfileBusinessState();
}

class _ProfileBusinessState extends State<ProfileBusiness> {
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
                initialValue: widget.businessProfile.name,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextFormField(
                initialValue: widget.businessProfile.webSite,
                decoration: InputDecoration(labelText: "Web Site"),
              ),
              TextFormField(
                initialValue: widget.businessProfile.phoneNumber,
                decoration: InputDecoration(labelText: "Phone Number"),
              ),
              TextFormField(
                initialValue: widget.businessProfile.address,
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
                  backgroundImage: NetworkImage(widget.businessProfile.image!),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Column(
                    children: [Subtitles(widget.businessProfile.name)],
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
              _buildFieldWithEditButton("Name: ", widget.businessProfile.name),
              _buildFieldWithEditButton(
                  "Web Site: ", widget.businessProfile.webSite),
              _buildFieldWithEditButton(
                  "Phone Number: ", widget.businessProfile.phoneNumber),
              _buildFieldWithEditButton(
                  "Address: ", widget.businessProfile.address),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Titles(20, "Projects"),
                  ActiveButton(8, "Add Project", () {}, 15)
                ],
              ),
              const SizedBox(height: 20),
              Card(
                child: Container(
                  height: 200,
                  width: 250,
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Titles(20, "you do not have projects"),
                      const Icon(
                        Icons.sentiment_dissatisfied_outlined,
                        size: 60,
                        color: Color(0XFF02AA8B),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
        child: const Text(
          "EDIT",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildFieldWithEditButton(String label, String? value) {
    final maxDisplayLength = 20;
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
}
