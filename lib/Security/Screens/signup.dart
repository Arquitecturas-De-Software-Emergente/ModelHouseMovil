import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_house/Security/Interfaces/User.dart';
import 'package:model_house/Security/Screens/signin.dart';
import 'package:model_house/Security/Services/User_Service.dart';

import '../../Shared/Widgets/buttons/ActiveButton.dart';
import '../../Shared/Widgets/buttons/DisabledButton.dart';
import '../../Shared/Widgets/buttons/Input.dart';
import '../../Shared/Widgets/texts/subtitles.dart';
import '../../Shared/Widgets/texts/titles.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final email = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();
  User? user;
  String? code;

  HttpUser? httpUser;
  void initState() {
    httpUser = HttpUser();
    super.initState();
  }

  Future signUp() async {
    if (password.text == confirm.text) {
      user = await httpUser?.signUp(email.text, password.text);
      setState(() {
        user = user;
        if (user != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const Signin();
              },
            ),
          );
        }
      });
    } else {
      const snackBar = SnackBar(
          content: Text('Passwords are not the same'),
          duration: Duration(seconds: 2),
          // ignore: use_full_hex_values_for_flutter_colors
          backgroundColor: Color(0xff7da4a3e));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
          child: ListView(
            children: <Widget>[
              Center(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Titles(35, "Sign Up"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: Image.asset(
                      'images/logo.png',
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Subtitles("Email Address"),
                    Input(Icons.visibility, "Type your Email Address", false,
                        email, false, TextInputType.emailAddress),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Subtitles("Password"),
                    Input(Icons.visibility, "Type your Password", true,
                        password, true, TextInputType.visiblePassword),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Subtitles("Confirm Password"),
                    Input(Icons.visibility, "Type Confirm Password", true,
                        confirm, true, TextInputType.visiblePassword),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: ActiveButton(25, "Sign Up", signUp, 19),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: DisabledButton(25, "Sign Up With Google", () {}),
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Do you have an account? ",
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  MaterialButton(
                    onPressed: redirectSignIn,
                    child: Text(
                      "Sign In",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }

  void redirectSignIn() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const Signin();
        },
      ),
    );
  }
}
