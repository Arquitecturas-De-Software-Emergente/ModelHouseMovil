import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:model_house/Security/Interfaces/Proyect.dart';
import 'package:model_house/Shared/Views/ProfileUser.dart';

class ProjectDetail extends StatelessWidget {
  final Proyect project;

  ProjectDetail(this.project);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 400,

              child: Image.network(
                project.image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                '${project.title}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text('Description: ${project.description}'),
            const SizedBox(height: 20),
            const Text(
              'Review:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10), // Espacio vertical entre el avatar y la información
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixabay.com%2Fillustrations%2Ficon-user-male-avatar-business-5359553%2F&psig=AOvVaw3z-QpkAnlKp_EtzqyU1AkC&ust=1698165957853000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCNjat6zPjIIDFQAAAAAdAAAAABAu"),
                  ),
                  const SizedBox(width: 10), // Espacio horizontal entre el avatar y la información
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            'User Name',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10), // Espacio horizontal entre el nombre de usuario y el texto de la revisión
                          Text(
                            'It’s a good business',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
