import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/ServicesManagement/Screens/BusinessContent,.dart';
import '../Widgets/texts/titles.dart';

// ignore: must_be_immutable
class ListBusiness extends StatefulWidget {
  List<BusinessProfile> business;
  UserProfile? userProfile;
  ListBusiness(this.business, this.userProfile, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListBusinessState createState() => _ListBusinessState();
}

class _ListBusinessState extends State<ListBusiness> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.business.length,
        itemBuilder: (context, index) {
          return cardBusiness(widget.business[index]);
        },
      ),
    );
  }

  Widget cardBusiness(BusinessProfile business) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
      child: MaterialButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return BusinessContent(business, widget.userProfile);
              },
            ),
          );
        },
        textColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(business.image),
                ),
                Column(
                  children: [Titles(18, business.name), Text(business.address)],
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return Container();
                          },
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.navigate_next_outlined,
                      color: Color.fromARGB(255, 52, 54, 52),
                      size: 40,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
