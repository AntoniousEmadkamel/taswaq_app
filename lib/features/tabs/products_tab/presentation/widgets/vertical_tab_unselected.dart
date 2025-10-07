import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerticalTabUnselected extends StatelessWidget {
  String widgetTitle;
  VerticalTabUnselected({required this.widgetTitle,super.key});

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: -1,
      child: Container(
        width: 137,
        height: 82,
        child: Expanded(child: Text("${widgetTitle}", softWrap: true,overflow:TextOverflow.visible,style:GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xff06004F)),)),
      ),
    );
  }
}
