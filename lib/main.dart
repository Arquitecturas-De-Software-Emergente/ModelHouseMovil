import 'package:flutter/material.dart';
import 'package:model_house/Security/Screens/welcomeApplication.dart';
import 'package:firebase_core/firebase_core.dart';

import 'ServicesManagement/Services/messaging_service.dart';
import 'ServicesManagement/Services/place_service.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "modelhouseemergentes",
      options: const FirebaseOptions(
          apiKey: "AIzaSyAeXhQADW_FIXt0g1yPhXK86pC4aEkPYi0",
          appId: "1:1039371106649:android:0e25c0a9a901731f1d3448",
          messagingSenderId: "1039371106649",
          projectId: "modelhouseemergentes",
          databaseURL: "https://modelhouseemergentes-default-rtdb.firebaseio.com"
      )
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

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
