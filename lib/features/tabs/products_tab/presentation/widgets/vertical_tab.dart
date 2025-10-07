import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerticalTab extends StatelessWidget {
  String widgetTitle;
   VerticalTab({required this.widgetTitle,super.key});

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: -1,
      child: Container(
        color: Colors.white,
        width: 137,
        height: 82,
        child: Row(

          children: [
            Container(
              width: 7,
              height: 72,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(20),
                color: Color(0xff004182),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(child: Text("${widgetTitle}", softWrap: true,overflow:TextOverflow.visible,style:GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xff06004F)),)),
          ],
        ),
      ),
    );
  }
}
