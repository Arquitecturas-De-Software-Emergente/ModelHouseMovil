import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/ServicesManagement/Interfaces/ProjectInterface.dart';
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
  List<ProjectInterface>? proyects;
  HttpBusinessProfile? httpBusinessProfile;
  String? name;
  String? webSite;
  String? phoneNumber;
  String? address;
  String? description;

  @override
  void initState() {
    httpProyect = HttpProyect();
    httpBusinessProfile = HttpBusinessProfile();
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

  void _performProfileUpdate() async {
    if (widget.businessProfile.id != null &&
        name != null &&
        webSite != null &&
        phoneNumber != null &&
        address != null &&
        description != null) {
      final updatedProfile = await httpBusinessProfile?.updateBusinessProfile(
        name!,
        webSite!,
        phoneNumber!,
        address!,
        description!,
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

  Widget _buildEditButton() {
    return ElevatedButton(
      onPressed: () {
        _editProfile();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0XFF02AA8B),
      ),
      child: Text("EDIT", style: TextStyle(color: Colors.white)),
    );
  }

  void _editProfile() {
    name = widget.businessProfile.name;
    webSite = widget.businessProfile.webSite;
    phoneNumber = widget.businessProfile.phoneNumber;
    address = widget.businessProfile.address;
    description = widget.businessProfile.description;

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
                  setState(() {
                    name = value;
                  });
                },
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextFormField(
                initialValue: webSite,
                onChanged: (value) {
                  setState(() {
                    webSite = value;
                  });
                },
                decoration: const InputDecoration(labelText: "Web Site"),
              ),
              TextFormField(
                initialValue: phoneNumber,
                onChanged: (value) {
                  setState(() {
                    phoneNumber = value;
                  });
                },
                decoration: const InputDecoration(labelText: "Phone Number"),
              ),
              TextFormField(
                initialValue: address,
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
                decoration: const InputDecoration(labelText: "Address"),
              ),
              TextFormField(
                initialValue: description,
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
                decoration: const InputDecoration(labelText: "Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _performProfileUpdate();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Titles(20, "Personal Information"),
                  _buildEditButton(),
                ],
              ),
              _buildField("Name: ", widget.businessProfile.name),
              _buildField("Web Site: ", widget.businessProfile.webSite),
              _buildField("Phone Number: ", widget.businessProfile.phoneNumber),
              _buildField("Address: ", widget.businessProfile.address),
              _buildField("Description: ", widget.businessProfile.description),
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
                                    project.image!,
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

  Widget _buildField(String label, String? value) {
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
      ],
    );
  }
}
