import 'package:flutter/material.dart';
import 'package:model_house/ServicesManagement/Screens/request/requests.dart';
import 'package:model_house/Shared/Components/navigate.dart';
import 'package:model_house/Shared/Widgets/texts/titles.dart';

class RequestOption extends StatelessWidget {
  const RequestOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Titles(32, 'My Requests'),
          RequestStateCards(),
        ],
      ),
    );
  }
}

class RequestStateCards extends StatelessWidget {
  RequestStateCards({super.key});
  final List<String> images = [
    'first-step-icon',
    'second-step-icon',
    'third-step-icon',
    'fourth-step-icon',
    'fifth-step-icon',
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          RequestStateCard('Requests', images[0]),
          RequestStateCard('Proposals', images[1]),
          RequestStateCard('Projects', images[2]),
          RequestStateCard('Completed Projects', images[3]),
          RequestStateCard('Canceled', images[4]),
        ],
      ),
    );
  }
}

class RequestStateCard extends StatelessWidget {
  final String name;
  final String image;
  const RequestStateCard(this.name, this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigate(context, Requests());
      },
      child: Container(
        width: 100.0,
        height: 100.0,
        child: Card(
          elevation: 4.0,
          margin: const EdgeInsets.all(32.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Centra verticalmente
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Centra horizontalmente
              children: [
                Padding(
                  padding: const EdgeInsets.all(
                      32.0), // Añade un padding de 8.0 a todos los lados del Text
                  child: Text(
                    name,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center, // Alinea el texto al centro
                  ),
                ),
                Image.asset('images/$image.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
