// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  Widget? suffixIcon;
  String? text;
  double? top;
  double? right;
  double? left;
  bool? obscureText;
  void Function(String)? onChanged;

  TextEditingController? controller;
  MyTextField(
      {Key? key,
      required this.text,
      required this.top,
      required this.right,
      required this.left,
      required this.obscureText,
      this.controller,
      this.suffixIcon,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: top!,
        left: left!,
        right: right!,
      ),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        obscureText: obscureText!,
        style: GoogleFonts.ubuntu(fontSize: 23, color: Colors.white),
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            labelText: text!,
            labelStyle: GoogleFonts.ubuntu(fontSize: 22, color: Colors.white),
            filled: true,
            fillColor: Color(0xFF323232),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12))),
      ),
    );
  }
}
