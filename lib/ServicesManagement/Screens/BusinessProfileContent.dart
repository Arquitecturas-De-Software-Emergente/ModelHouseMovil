import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:model_house/Security/Interfaces/Account.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/Security/Services/Account_Service.dart';
import 'package:model_house/Security/Services/Business_Profile.dart';
import 'package:model_house/ServicesManagement/Screens/CreateRequest.dart';
import 'package:model_house/ServicesManagement/Screens/ProjectDetails.dart';
import 'package:model_house/Shared/Views/Category.dart';
import 'package:social_media_flutter/social_media_flutter.dart';
import '../../Security/Interfaces/BusinessProfile.dart';
import '../../Security/Interfaces/Proyect.dart';
import '../../Security/Services/Proyect_Service.dart';
import '../../Shared/Widgets/texts/titles.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BusinessProfileContent extends StatefulWidget {
  BusinessProfile businessProfile;
  Account? account;
  BusinessProfileContent(this.businessProfile, this.account, {Key? key})
      : super(key: key);

  @override
  _BusinessProfileContentState createState() => _BusinessProfileContentState();
}

class _BusinessProfileContentState extends State<BusinessProfileContent> {
  HttpProyect? httpProyect;
  HttpAccount? httpAccount;
  Account? account;
  List<Proyect>? proyects;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController description = TextEditingController();

  final List<Category> categories = [
    Category(id: 1, name: "Category 1"),
    Category(id: 2, name: "Category 2"),
    Category(id: 3, name: "Category 3"),
  ];
  @override
  void initState() {
    httpProyect = HttpProyect();
    httpAccount = HttpAccount();
    getProjects();
    super.initState();
  }

  Future getProjects() async {
    if (widget.businessProfile.id != null) {
      proyects =
          await httpProyect?.getAllByBusinessId(widget.businessProfile.id!);
      setState(() {
        proyects = proyects;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Titles(20, "Business Profile"),
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
                widget.businessProfile.image!,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Positioned(
                top: 70,
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage: NetworkImage(widget.businessProfile.image!),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.businessProfile.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            RatingBar.builder(
              initialRating: 3, // review
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 25,
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Phone Number: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        "${widget.businessProfile.phoneNumber}",
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text(
                        "Official Web Page: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        "${widget.businessProfile.webSite}",
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text(
                        "Address: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        "${widget.businessProfile.address}",
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        "Email Address: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        "fre",
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Categories:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(height: 5),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: categories.map((category) {
                          return Chip(
                            label: Text(
                              category.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            backgroundColor: const Color(0xFF02AA8B),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Text(
                        "Social Media: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SocialWidget(
                        placeholderText: '',
                        iconData: SocialIconsFlutter.instagram,
                        iconColor: const Color(0xFF02AA8B),
                        link: 'https://www.instagram.com/',
                        iconSize: 20,
                      ),
                      SocialWidget(
                        placeholderText: '',
                        iconData: SocialIconsFlutter.linkedin,
                        iconColor: const Color(0xFF02AA8B),
                        link: 'https://www.linkedin.com/',
                        iconSize: 20,
                      ),
                      SocialWidget(
                        placeholderText: '',
                        iconData: SocialIconsFlutter.facebook,
                        iconColor: const Color(0xFF02AA8B),
                        link: 'https://www.facebook.com/',
                        iconSize: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "About Us:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(widget.businessProfile.description),
                  const SizedBox(height: 30),
                  const Text(
                    "Our Specialization:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Projects:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
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
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProjectDetail(project),
                              ));
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
                : Card(
                    child: Container(
                      height: 200,
                      width: 250,
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Titles(20, "you do not have projects"),
                          const Icon(
                            Icons.sentiment_dissatisfied_outlined,
                            size: 60,
                            color: Color(0XFF02AA8B),
                          ),
                        ],
                      ),
                    ),
                  ),
            SizedBox(height: 25),
            widget.account?.userProfileId != null &&
                    widget.account?.businessProfileId == null
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateRequest(
                              widget.businessProfile,
                              widget.account!.userProfileId!),
                        ),
                      );
                    },
                    child: const Text(
                      "Send Request",
                      style: TextStyle(fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF02AA8B),
                      minimumSize: const Size(350, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Border redondeado
                      ),
                    ),
                  )
                : Container(),
            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
