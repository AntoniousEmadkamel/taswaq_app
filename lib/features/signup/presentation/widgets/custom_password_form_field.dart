import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPasswordFormField extends StatelessWidget {
  String hintText;
  bool icon;
  bool isVisible;
  VoidCallback  onTap;
  TextEditingController controller;
  CustomPasswordFormField({required this.hintText,required this.icon, this.isVisible=false, required this.onTap,required this.controller,super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: icon ? !isVisible : false, // Use isVisible to control text visibility
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
        suffixIcon: icon
            ? IconButton(
          onPressed: onTap,
          icon: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off_rounded
          ),
        )
            : null, // Only show suffix icon if icon is true
      ),
    );
  }
}
