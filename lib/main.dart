import 'package:flutter/material.dart';
import 'package:model_house/Security/Screens/welcomeApplication.dart';
//import 'package:model_house/ServicesManagement/Screens/request/request_option.dart';
import 'package:model_house/ServicesManagement/Screens/Plans.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomeApplication(),
    );
  }
}
