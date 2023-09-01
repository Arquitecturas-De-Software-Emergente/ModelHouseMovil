import 'package:flutter/material.dart';
import 'package:model_house/Shared/Widgets/buttons/ActiveButton.dart';
import 'package:model_house/Shared/Widgets/texts/titles.dart';

class ProfileBusiness extends StatefulWidget {
  const ProfileBusiness({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileBusinessState createState() => _ProfileBusinessState();
}

class _ProfileBusinessState extends State<ProfileBusiness> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Titles(33, "Projects"),
            ActiveButton(8, "Add Project", () {}, 15)
          ],
        ),
        Card(
          child: Container(
            height: 250,
            width: 300,
            padding: const EdgeInsets.all(30),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Titles(20, "you do not have projects"),
              const Icon(
                Icons.sentiment_dissatisfied_outlined,
                size: 80,
                color: Color(0XFF02AA8B),
              )
            ]),
          ),
        )
      ]),
    );
  }
}
