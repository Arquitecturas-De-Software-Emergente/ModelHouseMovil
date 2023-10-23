import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/Shared/Views/ProfileBusiness.dart';
import 'package:model_house/Shared/Views/ProfileUser.dart';
import 'package:model_house/Shared/Widgets/texts/titles.dart';

import '../../Security/Interfaces/BusinessProfile.dart';

class Profile extends StatefulWidget {
  UserProfile? userProfile;
  BusinessProfile? businessProfile;
  Profile(this.userProfile, this.businessProfile, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF02AA8B),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => {Navigator.of(context).pop()},
        ),
      ),
      body: ListView(
        children: [
          if (widget.userProfile != null) ProfileUser(widget.userProfile!),
          if (widget.businessProfile != null)
            ProfileBusiness(widget.businessProfile!),
        ],
      ),
    );
  }
}
