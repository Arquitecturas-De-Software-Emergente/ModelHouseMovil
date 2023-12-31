import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  final Function currentIndex;
  const Navigation({Key? key, required this.currentIndex}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: (int i) {
        setState(() {
          index = i;
          widget.currentIndex(i);
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF02AA8B),
      unselectedItemColor: Colors.white,
      iconSize: 35.0,
      selectedFontSize: 14.0,
      unselectedFontSize: 12,
      backgroundColor: const Color(0XFF004A63),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Request'),
        BottomNavigationBarItem(
            icon: Icon(Icons.tablet_mac), label: 'Smart Devices'),
        BottomNavigationBarItem(
            icon: Icon(Icons.table_rows_rounded), label: 'Menu'),
      ],
    );
  }
}
