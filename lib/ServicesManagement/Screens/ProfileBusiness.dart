import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';

import '../../Security/Interfaces/Proyect.dart';
import '../../Security/Interfaces/User.dart';
import '../../Security/Services/Proyect_Service.dart';
import '../../Shared/Widgets/texts/titles.dart';

class ProfileBusiness extends StatefulWidget {
  User user;
  BusinessProfile businessProfile;
  ProfileBusiness(this.user, this.businessProfile, {Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileBusinessState createState() => _ProfileBusinessState();
}

class _ProfileBusinessState extends State<ProfileBusiness> {
  HttpProyect? httpProyect;
  List<Proyect>? proyects;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController description = TextEditingController();

  @override
  void initState() {
    httpProyect = HttpProyect();
    getBusiness();
    super.initState();
  }

  Future getBusiness() async {
    proyects =
        await httpProyect?.getAllByBusinessId(widget.businessProfile.id!);
    setState(() {
      proyects = proyects;
    });
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
      body: Container(
        padding: const EdgeInsets.all(0),
        child: ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              height: 200,
              child: Image.network(
                widget.businessProfile.image,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Container(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 7, left: 15, right: 15),
                  child: Titles(20, widget.businessProfile.name)),
            ),
            Container(
                padding: const EdgeInsets.only(
                    top: 7, bottom: 7, left: 15, right: 15),
                child: Text(widget.businessProfile.description)),
            Container(
                padding: const EdgeInsets.only(
                    top: 7, bottom: 7, left: 15, right: 15),
                child: Text(widget.businessProfile.address)),
            Container(
                padding: const EdgeInsets.only(
                    top: 7, bottom: 7, left: 15, right: 15),
                child: Text(widget.businessProfile.phoneBusiness)),
            Container(
                padding: const EdgeInsets.only(
                    top: 7, bottom: 7, left: 15, right: 15),
                child: Text(widget.businessProfile.webSite)),
            proyects != null
                ? Padding(
                    padding: const EdgeInsets.all(15),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: proyects?.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                proyects![index].image,
                                fit: BoxFit.cover,
                              ),
                            ));
                      },
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
