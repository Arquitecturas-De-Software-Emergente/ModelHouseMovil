import 'package:flutter/material.dart';
import 'package:model_house/Shared/Widgets/texts/titles.dart';

import '../../Shared/Widgets/texts/subtitles.dart';

class Adicional extends StatefulWidget {
  const Adicional({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AdicionalState createState() => _AdicionalState();
}

class _AdicionalState extends State<Adicional> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Titles(27, "Adicional"),
        Card(
          child: MaterialButton(
            onPressed: () {},
            child: Row(children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 12, 20, 12),
                child: Icon(
                  Icons.credit_card_outlined,
                  size: 30,
                ),
              ),
              Text("Cards")
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
                  Icons.payments_outlined,
                  size: 30,
                ),
              ),
              Text("Payments")
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
                  Icons.house_outlined,
                  size: 30,
                ),
              ),
              Text("Premiun")
            ]),
          ),
        )
      ],
    );
  }
}
