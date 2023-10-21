import 'package:flutter/material.dart';

Future navigate(BuildContext context, Widget destinationWidget) async {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => destinationWidget,
    ),
  );
}
