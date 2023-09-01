import 'package:flutter/cupertino.dart';
import 'package:model_house/Security/Interfaces/User.dart';
import 'package:model_house/Security/Interfaces/UserProfile.dart';

import '../../ServicesManagement/Screens/Options.dart';
import '../../ServicesManagement/Screens/Home.dart';
import '../../ServicesManagement/Screens/Payment.dart';
import '../../ServicesManagement/Screens/Menu.dart';

// ignore: must_be_immutable
class Routes extends StatefulWidget {
  final int index;
  User user;
  UserProfile? userProfile;
  Routes(this.index, this.user, this.userProfile, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> myList = [
      Home(widget.user, widget.userProfile),
      Options(widget.user, widget.userProfile),
      Payment(widget.user, widget.userProfile),
      Menu(widget.user, widget.userProfile),
    ];
    return myList[widget.index];
  }
}
