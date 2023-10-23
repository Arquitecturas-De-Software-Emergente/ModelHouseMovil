import 'package:flutter/material.dart';

class Subscribe extends StatefulWidget {
  const Subscribe({Key? key}) : super(key: key);

  @override
  _SubscribeState createState() => _SubscribeState();
}

class _SubscribeState extends State<Subscribe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            '../images/background-subscribe.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 3.5,
            left: 0,
            right: 0,
            bottom: 0,
            child: Card(
              elevation: 8,
              color: Colors.transparent,
              margin: const EdgeInsets.all(0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: Text(
                            'Upgrade plan to highly experience',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            'Explore exclusive content and enjoy an enhanced experience with our Premium Plans',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Color(0xFF02AA8B), width: 1),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            margin: const EdgeInsets.all(30),
                            child: Container(
                              padding: const EdgeInsets.all(25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Basic Plan',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF718096)),
                                      ),
                                      Text(
                                        'Perfect your starters',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF718096)),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        '\$40',
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF718096)),
                                      ),
                                      Text(
                                        '/month',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF718096)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFEDF2F7),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            margin: const EdgeInsets.all(25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  margin: const EdgeInsets.only(top: 5),
                                  child: const Center(
                                    child: Text(
                                      'Recommended',
                                      style: TextStyle(
                                        color: Color(0xFF4A5568),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Color(0xFF02AA8B), width: 1),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  margin: const EdgeInsets.all(5),
                                  child: Container(
                                    padding: const EdgeInsets.all(30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Premium Plan',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF718096)),
                                            ),
                                            Text(
                                              'Perfect your starters',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Color(0xFF718096)),
                                              textAlign: TextAlign.right,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              '\$70',
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF718096)),
                                            ),
                                            Text(
                                              '/month',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF718096)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
