import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const CustomTextFormField({
    required this.hintText,
    required this.controller,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w300,
            fontSize: 18,
            color: Colors.black
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)
        ),
      ),
    );
  }
}