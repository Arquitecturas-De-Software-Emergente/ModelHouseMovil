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
  int? idAccount;
  String? role;
  UserProfile? userProfile;
  Routes(this.index, this.idAccount, this.role, this.userProfile, {Key? key}) : super(key: key);

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
      Home(widget.userProfile),
      Options(widget.idAccount, widget.userProfile),
      Payment(widget.userProfile),
      Menu(widget.idAccount, widget.role, widget.userProfile),
    ];
    return myList[widget.index];
  }
}
