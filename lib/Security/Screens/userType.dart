import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_house/Security/Interfaces/Account.dart';
import 'package:model_house/Security/Screens/formBusinessProfile.dart';
import 'package:model_house/Security/Screens/formUserProfile.dart';
import 'package:model_house/Security/Services/Account_Service.dart';
import 'package:model_house/Shared/Widgets/texts/titles.dart';

import '../../Shared/Components/PrincipalView.dart';
import '../../Shared/Widgets/buttons/ActiveButton.dart';

class UserType extends StatefulWidget {
  Account account;
  UserType(this.account, {super.key});

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Titles(33, "Business Profile"),
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
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 35, 0, 25),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return FormUserProfile(widget.account);
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.blue, width: 2.0),
                            ),
                            child: ClipOval(
                                child: Image.network('https://i.pinimg.com/736x/b3/b8/57/b3b85713a822ad3e2c5e1eb74af91554.jpg',
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,)
                            )
                        ),
                        Titles(20, "Simple Person")
                      ]
                    ),
                  )
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 25),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return FormBusinessProfile(widget.account);
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.blue, width: 2.0),
                              ),
                              child: ClipOval(
                                  child: Image.network('https://img.freepik.com/vector-gratis/ilustracion-concepto-empresa_114360-2581.jpg',
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,)
                              )
                          ),
                          Titles(20, "Business")
                        ]
                    ),
                  )
                ),
              )
            ],
          ),
        ),
    ));
  }
}
