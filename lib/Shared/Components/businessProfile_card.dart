import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/ServicesManagement/Screens/BusinessProfileContent.dart';
import 'package:model_house/Shared/Components/navigate.dart';

import '../../Security/Interfaces/Account.dart';

class BusinessProfileCard extends StatefulWidget {
  final int? id;
  final String address;
  final String description;
  final String image;
  final String name;
  final String phoneNumber;
  final String webSite;
  final Account account;

  BusinessProfileCard(
    this.account, {
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
  State<BusinessProfileCard> createState() => _BusinessProfileCardState();
}

class _BusinessProfileCardState extends State<BusinessProfileCard> {
  @override
  Widget build(BuildContext context) {
    final businessprofile = BusinessProfile(
      id: widget.id,
      address: widget.address,
      description: widget.description,
      image: widget.image,
      name: widget.name,
      phoneNumber: widget.phoneNumber,
      webSite: widget.webSite,
    );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ClipOval(
                    child: Container(
                      width: 80.0,
                      height: 80.0,
                      child: Image.network(widget.image),
                    ),
                  ),
                ],
              ),

              SizedBox(width: 16.0), // Espacio entre la imagen y el contenido
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
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
                      widget.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
              SizedBox(width: 16.0), // Espacio entre el contenido y el botón
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.arrow_circle_right_outlined),
                      color: const Color(0xFF02AA8B),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BusinessProfileContent(
                                businessprofile, widget.account),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        Text("Perú, Lima"),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite,
                          color: Color.fromARGB(255, 196, 6, 6)),
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
