import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/Account.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/ServicesManagement/Screens/BusinessProfileContent.dart';
import 'package:model_house/Shared/Views/FormBusinessProfile.dart';

class PerfilBusiness extends StatefulWidget {
  Account account;
  BusinessProfile businessProfile;
  PerfilBusiness(this.account, this.businessProfile, {Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PerfilBusinessState createState() => _PerfilBusinessState();
}

class _PerfilBusinessState extends State<PerfilBusiness> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.only(bottom: 30),
        child: MaterialButton(
          padding: const EdgeInsets.all(15),
          onPressed: redirectPerfilBusiness,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              widget.businessProfile.image == null
                  ? const Icon(
                      Icons.person,
                      color: Color(0XFF02AA8B),
                      size: 40,
                    )
                  : CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(widget.businessProfile.image),
                    ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                      widget.businessProfile.name,
                      style: const TextStyle(
                          color: Color(0XFF02AA8B),
                          fontSize: 19,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(widget.businessProfile.phoneBusiness,
                      style: const TextStyle(color: Color(0XFF02AA8B)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void redirectPerfilBusiness() {
    widget.account != null
        ? Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return BusinessProfileContent(widget.businessProfile);
              },
            ),
          )
        :
        // ignore: unnecessary_null_comparison
        Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return FormProfileBusines(widget.account);
              },
            ),
          );
  }
}
