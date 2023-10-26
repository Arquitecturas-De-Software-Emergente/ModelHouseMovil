import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Security/Interfaces/BusinessProfile.dart';
import '../../../Security/Interfaces/UserProfile.dart';
import '../../../Shared/Widgets/texts/titles.dart';

class FormProposal extends StatefulWidget {
  UserProfile? userProfile;
  BusinessProfile? businessProfile;
  FormProposal(this.userProfile, this.businessProfile, {super.key});

  @override
  State<FormProposal> createState() => _FormProposalState();
}

class _FormProposalState extends State<FormProposal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Titles(28, "Form Proposal"),
          backgroundColor: const Color(0xffffffff),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0XFF02AA8B),
            ),
            onPressed: () => {Navigator.of(context).pop()},
          ),
        )
    );
  }
}
