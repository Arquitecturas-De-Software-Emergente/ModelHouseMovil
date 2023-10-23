import 'package:flutter/material.dart';
import 'package:model_house/ServicesManagement/Screens/Subscribe.dart';

class Plan extends StatefulWidget {
  const Plan({Key? key}) : super(key: key);

  @override
  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  void _navigateToSubscribe() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Subscribe()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plans'),
        backgroundColor: const Color(0XFF02AA8B),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 400,
              child: Image.asset(
                '../images/background-plans.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 80),
              child: const Text(
                'Publish your project and start getting close with your clients',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: _navigateToSubscribe,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF02AA8B),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Get Premium',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 80),
              child: const Text(
                'why go premium?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            const Column(
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30),
                  leading: Icon(Icons.check, color: Color(0XFF02AA8B)),
                  title: Text('Publish your projects as a company'),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30),
                  leading: Icon(Icons.check, color: Color(0XFF02AA8B)),
                  title: Text('View your orders'),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30),
                  leading: Icon(Icons.check, color: Color(0XFF02AA8B)),
                  title: Text('See comments of your projects'),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30),
                  leading: Icon(Icons.check, color: Color(0XFF02AA8B)),
                  title: Text('Manage your credit cards'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
