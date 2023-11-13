import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_house/Security/Interfaces/Proyect.dart';
import 'package:model_house/ServicesManagement/Interfaces/ProjectInterface.dart';
import 'package:model_house/ServicesManagement/Interfaces/Rating.dart';
import 'package:model_house/Shared/Views/ProfileUser.dart';

import '../Services/ReviewService.dart';

class ProjectDetail extends StatefulWidget {
  ProjectInterface? project;

  ProjectDetail(this.project, {super.key});

  @override
  State<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  Rating? rating;
  HttpReview? httpReview;
  @override
  void initState() {
    httpReview = HttpReview();
    getReview();
    super.initState();
  }

  Future getReview() async {
    rating = await HttpReview().getReviewId(widget.project!.id!);
    setState(() {
      print('$rating ALGO');
      rating = rating;
    });
  }

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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  widget.project!.image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                '${widget.project?.title}',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(widget.project!.description!, style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),),
            ),
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
              padding: const EdgeInsets.symmetric(
                  vertical:
                      10), // Espacio vertical entre el avatar y la información
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(widget.project!.imageUserProfile!),
                  ),
                  const SizedBox(
                      width:
                          10), // Espacio horizontal entre el avatar y la información
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
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          // actualización de la puntuación de la revisión
                        },
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          Text(
                            '${widget.project?.firstName!} ${widget.project!.lastName!}',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                              width:
                                  10), // Espacio horizontal entre el nombre de usuario y el texto de la revisión
                          Text(
                            '${rating?.comment}',
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
