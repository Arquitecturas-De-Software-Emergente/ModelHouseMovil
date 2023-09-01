import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class Subtitles extends StatefulWidget {
  String? text;

  Subtitles(this.text, {Key? key}) : super(key: key);

  @override
  _SubtitlesState createState() => _SubtitlesState();
}

class _SubtitlesState extends State<Subtitles> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text!,
      style: GoogleFonts.poppins(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: const Color(0XFF383737)),
    );
  }
}
