import 'package:flutter/material.dart';
import 'package:model_house/Shared/Components/request_card.dart';
import 'package:model_house/Shared/Widgets/texts/titles.dart';

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _Requests();
}

class _Requests extends State<Requests> {
  final int num = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Titles(32, 'Requests'),
          Expanded(
            child: ListView.builder(
              itemCount: num, // Número de elementos en la lista
              itemBuilder: (context, index) {
                return RequestCard(
                    'GOED',
                    'lorem ipsum dolor bla bla bla f g  g  g gregwer g werg werg  wegr wergerw gwer gwer g wefwe fewfwe fewf wef wefwe fwef wefwe werg wer',
                    Container(),
                    Container());
              },
            ),
          ),
        ],
      ),
    );
  }
}
