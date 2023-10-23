import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/ServicesManagement/Screens/BusinessProfileContent.dart';
import 'package:model_house/Shared/Components/navigate.dart';

import 'package:flutter/material.dart';
import 'package:model_house/Shared/Components/navigate.dart';

class BusinessProfileCard extends StatelessWidget {
  final int? id;
  final String address;
  final String description;
  final String image;
  final String name;
  final String phoneNumber;
  final String webSite;
  
  const BusinessProfileCard({
    this.id,
    required this.address,
    required this.description,
    required this.image,
    required this.name,
    required this.phoneNumber,
    required this.webSite,

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final businessprofile = BusinessProfile(
      id: id,
      address: address, 
      description: description, 
      image: image, name: name, 
      phoneNumber: phoneNumber, 
      webSite: webSite);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 80.0,
                child: Image.network(image),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    RatingBar.builder(
                      initialRating: 3, // review
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 20,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        // actualización de la puntuación de la revisión
                      },
                    ),
                    const SizedBox(height: 8.0),

                    Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget> [
                    IconButton(
                      icon: const Icon(Icons.arrow_circle_right_outlined),
                      color: const Color(0xFF02AA8B),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>  BusinessProfileContent(businessprofile),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8.0),
                    const Row(
                      children: <Widget>[
                        Icon(Icons.location_on, color: Color.fromARGB(255, 0, 0, 0),), // Ícono de ubicación
                        Text("Perú, Lima"),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite, color: Color.fromARGB(255, 196, 6, 6),),
                      onPressed: () {
                        // Agregar la lógica para manejar favoritos aquí
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
