import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPasswordFormFieldForSettings extends StatelessWidget {
  String hintText;
  bool icon;
  bool isVisible;
  CustomPasswordFormFieldForSettings({required this.hintText,required this.icon, this.isVisible=false,super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: icon ? !isVisible : false, // Use isVisible to control text visibility
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Color(0xff06004F)
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        suffixIcon: Icon(
            isVisible ? Icons.visibility : Icons.edit_rounded
        ), // Only show suffix icon if icon is true
      ),
    );
  }
}
