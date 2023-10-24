import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/Shared/Widgets/buttons/ActiveButton.dart';
import 'package:model_house/Shared/Widgets/texts/titles.dart';
import 'package:model_house/Shared/Widgets/texts/subtitles.dart';
import 'package:model_house/ServicesManagement/Screens/ProjectDetails.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../Security/Services/Business_Profile.dart';
import '../../Security/Services/Proyect_Service.dart';
import '../../Security/Interfaces/Proyect.dart';
import 'package:model_house/Shared/HttpComon.dart';

class ProfileBusiness extends StatefulWidget {
  BusinessProfile businessProfile;
  ProfileBusiness(this.businessProfile, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileBusinessState createState() => _ProfileBusinessState();
}

class _ProfileBusinessState extends State<ProfileBusiness> {
  HttpProyect? httpProyect;
  List<Proyect>? proyects;
  HttpBusinessProfile? httpBusinessProfile;

  @override
  void initState() {
    httpProyect = HttpProyect();
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

  void _performProfileUpdate(
      String name, String webSite, String phoneNumber, String address) async {
    print(
        "Before Update - Name: $name, WebSite: $webSite, Phone Number: $phoneNumber, Address: $address");
    if (widget.businessProfile.id != null) {
      final updatedProfile = await httpBusinessProfile?.updateBusinessProfile(
        name,
        webSite,
        phoneNumber,
        address,
        widget.businessProfile.id!,
      );
      if (updatedProfile != null) {
        setState(() {
          widget.businessProfile = updatedProfile;
        });
      } else {
        print("Update fails");
      }
    }
  }

  void _editProfile() {
    String name = widget.businessProfile.name;
    String webSite = widget.businessProfile.webSite;
    String phoneNumber = widget.businessProfile.phoneNumber;
    String address = widget.businessProfile.address;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Update Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: name,
                onChanged: (value) {
                  name = value;
                },
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextFormField(
                initialValue: webSite,
                onChanged: (value) {
                  webSite = value;
                },
                decoration: const InputDecoration(labelText: "Web Site"),
              ),
              TextFormField(
                initialValue: phoneNumber,
                onChanged: (value) {
                  phoneNumber = value;
                },
                decoration: const InputDecoration(labelText: "Phone Number"),
              ),
              TextFormField(
                initialValue: address,
                onChanged: (value) {
                  address = value;
                },
                decoration: const InputDecoration(labelText: "Address"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _performProfileUpdate(name, webSite, phoneNumber, address);
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 30, 40, 30),
          child: Center(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.businessProfile.image!),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Column(
                    children: [Subtitles(widget.businessProfile.name)],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Titles(20, "Personal Information"),
              ),
              _buildFieldWithEditButton("Name: ", widget.businessProfile.name),
              _buildFieldWithEditButton(
                  "Web Site: ", widget.businessProfile.webSite),
              _buildFieldWithEditButton(
                  "Phone Number: ", widget.businessProfile.phoneNumber),
              _buildFieldWithEditButton(
                  "Address: ", widget.businessProfile.address),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Titles(20, "Projects"),
                ],
              ),
              const SizedBox(height: 20),
              proyects?.isEmpty == false
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
            ],
          ),
        ),
      ],
    );
  }

  Widget customEditButton(VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          //border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Text(
          "EDIT",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildFieldWithEditButton(String label, String? value) {
    final maxDisplayLength = 20;
    final displayValue = value ?? "...";
    final truncatedValue = displayValue.length <= maxDisplayLength
        ? displayValue
        : displayValue.substring(0, maxDisplayLength) + "...";

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              Titles(15, label),
              Subtitles(truncatedValue),
            ],
          ),
        ),
        customEditButton(() {
          _editProfile();
        }),
      ],
    );
  }
}
