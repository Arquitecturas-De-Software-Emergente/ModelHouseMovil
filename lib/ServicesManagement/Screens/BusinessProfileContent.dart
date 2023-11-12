import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:model_house/Security/Interfaces/Account.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/Security/Services/Account_Service.dart';
import 'package:model_house/Security/Services/Business_Profile.dart';
import 'package:model_house/ServicesManagement/Interfaces/ProjectInterface.dart';
import 'package:model_house/ServicesManagement/Screens/CreateRequest.dart';
import 'package:model_house/ServicesManagement/Screens/ProjectDetails.dart';
import 'package:model_house/Shared/Views/Category.dart';
import 'package:social_media_flutter/social_media_flutter.dart';
import '../../Security/Interfaces/BusinessProfile.dart';
import '../../Security/Interfaces/Proyect.dart';
import '../../Security/Services/Proyect_Service.dart';
import '../../Shared/Widgets/CustomInformCard.dart';
import '../../Shared/Widgets/texts/titles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:animations/animations.dart';

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
  List<ProjectInterface>? projects;
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
      projects =
          await httpProyect?.getAllByBusinessId(widget.businessProfile.id!);
      setState(() {
        projects = projects;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Titles(20, "Business Profile"),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0XFF02AA8B),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                  height: 250,
                ),
                Positioned(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 6),
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        image: NetworkImage(widget.businessProfile
                            .image!), // Reemplaza con la ruta de tu imagen
                        fit: BoxFit
                            .cover, // Ajusta la forma en que la imagen se ajusta al contenedor
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(
                              0.2), // Color de la sombra y opacidad
                          blurRadius: 5, // Radio de desenfoque
                          spreadRadius: 1, // Radio de expansión
                          offset: Offset(
                              0, 4), // Desplazamiento (horizontal, vertical)
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom:
                      -10, // Ajusta la posición vertical para que el círculo flote hacia arriba
                  left: (MediaQuery.of(context).size.width - 150) /
                      2, // Ajusta la posición horizontal para centrar el círculo
                  child: CircleAvatar(
                    radius: 75,
                    backgroundImage:
                        NetworkImage(widget.businessProfile.image!),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.businessProfile.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 25,
              itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                // Actualización de la puntuación de la revisión
              },
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomInfoCard(
                    Icons.phone_iphone_outlined,
                    "Phone Number:",
                    "${widget.businessProfile.phoneNumber}",
                  ),
                  SizedBox(height: 5),
                  CustomInfoCard(
                    Icons.web_outlined,
                    "Official Web Page: ",
                    "${widget.businessProfile.webSite}",
                  ),
                  SizedBox(height: 5),
                  CustomInfoCard(
                    Icons.map_outlined,
                    "Address: ",
                    "${widget.businessProfile.address}",
                  ),
                  SizedBox(height: 5),
                  CustomInfoCard(
                    Icons.email_outlined,
                    "Email Address: ",
                    "Free",
                  ),
                  SizedBox(height: 15),
                  Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Categories:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: categories.map((category) {
                              return Chip(
                                label: Text(
                                  category.name,
                                  style: TextStyle(
                                    color: Color(0xFF02AA8B), // Color del texto
                                    fontSize: 14,
                                  ),
                                ),
                                backgroundColor:
                                    Colors.white, // Color de fondo del Chip
                                elevation: 3,
                                labelPadding:
                                    EdgeInsets.symmetric(horizontal: 8),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Color(0xFF02AA8B), // Color del borde
                                    width: 1.5, // Ancho del borde
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      30), // Bordes redondeados
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.black, // Color del texto
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 10),
                        ],
                      )),
                  SizedBox(height: 10),
                  Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Social Media: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SocialWidget(
                            placeholderText: '',
                            iconData: SocialIconsFlutter.instagram,
                            iconColor: Color(0xFF02AA8B),
                            link: 'https://www.instagram.com/',
                            iconSize: 20,
                          ),
                          SocialWidget(
                            placeholderText: '',
                            iconData: SocialIconsFlutter.linkedin,
                            iconColor: Color(0xFF02AA8B),
                            link: 'https://www.linkedin.com/',
                            iconSize: 20,
                          ),
                          SocialWidget(
                            placeholderText: '',
                            iconData: SocialIconsFlutter.facebook,
                            iconColor: Color(0xFF02AA8B),
                            link: 'https://www.facebook.com/',
                            iconSize: 20,
                          ),
                        ],
                      )),
                  SizedBox(height: 10),
                  Text(
                    "Projects:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            projects != null && projects!.isNotEmpty
                ? CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                      enableInfiniteScroll: false,
                    ),
                    items: projects!
                        .where((project) => project.status == "Completado")
                        .map((project) {
                      return Builder(
                        builder: (BuildContext context) {
                          return OpenContainer(
                            transitionDuration:
                                const Duration(milliseconds: 600),
                            transitionType: ContainerTransitionType.fade,
                            openBuilder: (BuildContext context,
                                VoidCallback openContainer) {
                              return ProjectDetail(project);
                            },
                            closedBuilder: (BuildContext context,
                                VoidCallback openContainer) {
                              return GestureDetector(
                                onTap: openContainer,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      project.image!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }).toList(),
                  )
                : Card(
                    child: Container(
                      height: 200,
                      width: 250,
                      color: Colors.white,
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Titles(15, "You do not have projects"),
                          Image.asset("images/person_sad.png", height: 110,),
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
                            widget.account!.userProfileId!,
                            widget.account!,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Send Request",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF02AA8B),
                      minimumSize: Size(350, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
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
