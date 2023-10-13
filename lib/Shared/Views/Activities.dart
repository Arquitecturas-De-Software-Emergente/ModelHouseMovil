import 'package:flutter/material.dart';
import 'package:model_house/Shared/Widgets/texts/titles.dart';

class Activities extends StatefulWidget {
  const Activities({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Titles(20, "Activities"),
        Card(
          child: MaterialButton(
            onPressed: () {},
            child: Row(children: const <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 12, 20, 12),
                child: Icon(
                  Icons.favorite_border_outlined,
                  size: 30,
                ),
              ),
              Text("Favorites")
            ]),
          ),
        ),
        Card(
          child: MaterialButton(
            onPressed: () {},
            child: Row(children: const <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 12, 20, 12),
                child: Icon(
                  Icons.add_box_outlined,
                  size: 30,
                ),
              ),
              Text("Add smart devices")
            ]),
          ),
        ),
        Card(
          child: MaterialButton(
            onPressed: () {},
            child: Row(children: const <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 12, 20, 12),
                child: Icon(
                  Icons.settings_outlined,
                  size: 30,
                ),
              ),
              Text("Smart devices configuration")
            ]),
          ),
        )
      ],
    );
  }
}
