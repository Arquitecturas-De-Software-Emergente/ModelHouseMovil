import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Titles extends StatefulWidget {
  String? text;
  double size;

  Titles(this.size, this.text, {Key? key}) : super(key: key);
  @override
  State<Titles> createState() => _TitlesState();
}

class _TitlesState extends State<Titles> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text!,
      style: GoogleFonts.poppins(
          fontSize: widget.size,
          fontWeight: FontWeight.w600,
          color: const Color(0XFF152031)),
    );
  }
}
