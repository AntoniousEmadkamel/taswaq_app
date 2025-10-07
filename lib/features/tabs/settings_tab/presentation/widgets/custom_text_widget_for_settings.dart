import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextWidgetForSettings extends StatelessWidget {
  String text;
  CustomTextWidgetForSettings({required this.text ,super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize:18 ,color: Color(0xff06004f)));
  }
}
