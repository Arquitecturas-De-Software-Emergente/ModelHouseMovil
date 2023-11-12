import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/Account.dart';
import 'package:model_house/Security/Interfaces/BusinessProfile.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';
import 'package:model_house/Security/Screens/welcomeApplication.dart';
import 'package:model_house/Security/Services/Account_Service.dart';
import 'package:model_house/Security/Services/Business_Profile.dart';
import 'package:model_house/ServicesManagement/Screens/Profile.dart';
import 'package:model_house/Shared/Components/navigate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Shared/Views/Activities.dart';
import '../../Shared/Views/Adicional.dart';

// ignore: must_be_immutable
class Menu extends StatefulWidget {
  Account account;
  UserProfile? userProfile;
  BusinessProfile? businessProfile;
  Menu(this.account, this.userProfile, this.businessProfile, {Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  HttpBusinessProfile? httpBusinessProfile;
  HttpAccount? httpAccount;
  Account? account;
  BusinessProfile? businessProfile;
  String? token;
  @override
  void initState() {
    print(widget.businessProfile);
    httpBusinessProfile = HttpBusinessProfile();
    httpAccount = HttpAccount();
    if (widget.account.businessProfileId != null) {
      //activeBusiness();
    }
    super.initState();
  }

  Future getBusiness() async {
    businessProfile =
        await httpBusinessProfile?.getbusinessProfileAccountById(account!.id!);
    if (businessProfile != null) {
      setState(() {
        businessProfile = businessProfile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          widget.account.userProfileId != null
              ? ElevatedButton(
                  onPressed: () {
                    navigate(
                        context,
                        Profile(
                          widget.userProfile != null
                              ? widget.userProfile!
                              : null,
                          widget.businessProfile != null
                              ? widget.businessProfile!
                              : null,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    primary: Colors.white
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(25),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: widget.userProfile?.image != null
                              ? NetworkImage(widget.userProfile!.image!)
                              : const AssetImage('../images/profile.png')
                                  as ImageProvider,
                        ),
                        const SizedBox(width: 30),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${(widget.userProfile?.firstName ?? "") + (" ") + (widget.userProfile?.lastName ?? "")}'
                                              .length <=
                                          12
                                      ? (widget.userProfile?.firstName ?? "") +
                                          (" ") +
                                          (widget.userProfile?.lastName ?? "")
                                      : '${(widget.userProfile?.firstName ?? "") + (" ") + (widget.userProfile?.lastName ?? "").substring(0, 9)}...',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  widget.account.emailAddress,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
              : ElevatedButton(
                  onPressed: () {
                    navigate(
                        context,
                        Profile(
                          widget.userProfile != null
                              ? widget.userProfile!
                              : null,
                          widget.businessProfile != null
                              ? widget.businessProfile!
                              : null,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(25),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: widget.businessProfile?.image != null
                              ? NetworkImage(widget.businessProfile!.image!)
                              : const AssetImage('../images/profile.png')
                                  as ImageProvider,
                        ),
                        SizedBox(width: 30),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.businessProfile?.name}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  widget.account.emailAddress,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: const [
                Activities(),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
                  child: Adicional(),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: MaterialButton(
              height: 45,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: const Color(0XFF02AA8B),
              onPressed: () async {
                final persitence = await SharedPreferences.getInstance();
                persitence.remove("token");
                // ignore: use_build_context_synchronously
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const WelcomeApplication();
                    },
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                      child: Icon(
                        Icons.logout_outlined,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Log Out",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
