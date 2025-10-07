import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextWidgetForSignup extends StatelessWidget {
  String text;
  CustomTextWidgetForSignup({required this.text ,super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize:18 ,color: Colors.white));
  }
}
