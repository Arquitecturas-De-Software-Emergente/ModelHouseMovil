import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class Input extends StatefulWidget {
  String? text;
  IconData icon;
  bool? visibility;
  TextEditingController? variable;
  bool? obscureText;
  TextInputType? inputType;
  Input(this.icon, this.text, this.visibility, this.variable, this.obscureText,
      this.inputType,
      {Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    if (widget.visibility!) {
      return TextField(
        controller: widget.variable,
        obscureText: widget.obscureText!,
        keyboardType: widget.inputType,
        style:
            GoogleFonts.poppins(fontSize: 14, color: const Color(0XFF02AA8B)),
        decoration: InputDecoration(
            hintText: widget.text,
            hintStyle: const TextStyle(color: Color(0XFF02AA8B)),
            fillColor: Colors.white,
            filled: true,
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0XFF02AA8B))),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0XFF02AA8B))),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  widget.inputType == TextInputType.visiblePassword
                      ? widget.obscureText = !widget.obscureText!
                      : null;
                });
              },
              icon: Icon(
                widget.icon,
                color: const Color(0XFF02AA8B),
              ),
            )),
      );
    }
    return TextField(
        keyboardType: widget.inputType,
        controller: widget.variable,
        style:
            GoogleFonts.poppins(fontSize: 14, color: const Color(0XFF02AA8B)),
        decoration: InputDecoration(
          hintText: widget.text,
          hintStyle: const TextStyle(color: Color(0XFF02AA8B)),
          fillColor: Colors.white,
          filled: true,
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0XFF02AA8B))),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0XFF02AA8B))),
        ));
  }
}
