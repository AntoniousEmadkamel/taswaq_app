import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormFieldForSettings extends StatelessWidget {
  final String hintText;
  const CustomTextFormFieldForSettings({
    required this.hintText,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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