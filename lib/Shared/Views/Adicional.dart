import 'package:flutter/material.dart';
import 'package:model_house/Shared/Widgets/texts/titles.dart';
import 'package:model_house/ServicesManagement/Screens/Plans.dart';

import '../../Shared/Widgets/texts/subtitles.dart';

class Adicional extends StatefulWidget {
  const Adicional({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AdicionalState createState() => _AdicionalState();
}

class _AdicionalState extends State<Adicional> {
  void _navigateToPlans() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Plan()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Titles(20, "Additional"),
        Card(
          child: MaterialButton(
            onPressed: _navigateToPlans,
            child: Row(children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 12, 20, 12),
                child: Icon(
                  Icons.person_add_alt_outlined,
                  size: 30,
                ),
              ),
              Text("Subscribe to ModelHouse")
            ]),
          ),
        ),
        Card(
          child: MaterialButton(
            onPressed: () {},
            child: Row(children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 12, 20, 12),
                child: Icon(
                  Icons.notification_add_outlined,
                  size: 30,
                ),
              ),
              Text("Notifications")
            ]),
          ),
        ),
      ],
    );
  }
}
