import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:model_house/Security/Services/Business_Profile.dart';
import '../../Security/Interfaces/BusinessProfile.dart';
import '../../Security/Interfaces/Proyect.dart';
import '../../Security/Services/Proyect_Service.dart';
import '../../Shared/Widgets/texts/titles.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BusinessProfileContent extends StatefulWidget {
  BusinessProfile businessProfile;
  BusinessProfileContent(this.businessProfile, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BusinessProfileContentState createState() => _BusinessProfileContentState();
}

class _BusinessProfileContentState extends State<BusinessProfileContent> {
  HttpProyect? httpProyect;
  List<Proyect>? proyects;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController description = TextEditingController();

  @override
  void initState() {
    httpProyect = HttpProyect();
    getProjects();
    super.initState();
  }

Future getProjects() async {
  if (widget.businessProfile.id != null) {
    proyects = await httpProyect?.getAllByBusinessId(widget.businessProfile.id!);
    setState(() {
      proyects = proyects;
    });
  }
}

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Titles(28, "Business Profile"),
        backgroundColor: const Color(0xffffffff),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0XFF02AA8B),
          ),
          onPressed: () => {Navigator.of(context).pop()},
        ),
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
            Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Image.network(
              'URL_IMAGEN_DE_PORTADA',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          
          Center(

            child: 
            Positioned(
              top: 70,
              child:
            CircleAvatar(
              radius: 75,
              backgroundImage: NetworkImage(widget.businessProfile.image!),
            )
            ),
          ),
          const SizedBox(height: 10),
          Center(child: Text(
                widget.businessProfile.name,
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
              ),),

              const SizedBox(height: 10),
              RatingBar.builder(
                      initialRating: 3, // review
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 50,
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

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Text("Phone Number: ${widget.businessProfile.phoneNumber}"),
                Text("Official Web Page: ${widget.businessProfile.webSite}"),
                Text("Address: ${widget.businessProfile.address}"),
                //Text("Email Address: ${widget.businessProfile.email}"),
                //Text("Category: ${widget.businessProfile.category}"),
                //Text("Social Media: ${widget.businessProfile.socialMedia}"),
                const SizedBox(height: 10),
                const Text("About Us:", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,)),
                Text(widget.businessProfile.description),
                const SizedBox(height: 10),
                const Text("Our Specialization:", style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,)),
            ],
          ),
          const SizedBox(height: 10),
        
          

          const Padding(
  padding: EdgeInsets.all(30),
  child: Align(
    alignment: Alignment.centerLeft,
    child: Text(
      "Projects:",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
          
          proyects != null
              ? CarouselSlider(
                  options: CarouselOptions(
                    height: 200,
                  ),
                  items: proyects!.map((project) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                project.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                )
              : Container(),
              
          SizedBox(height: 70),
          
          ElevatedButton(
            onPressed: () {
              
            },
            child: const Text("Send Request"),
            style: ElevatedButton.styleFrom(
            primary: const Color(0xFF02AA8B),
            minimumSize: const Size(200, 50), 
  ),
          ),
        ],
      ),
    ),
  );
}

}