import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionBox extends StatelessWidget {
  String question;

  QuestionBox({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: size.width*0.02, right: size.height*0.04),
      child: SizedBox(
        width: size.width*0.8,
        height: size.height*0.18,
        child: Text(
          question,
          // 'Which of the following\n technology used by zomato for\n food delivery ?',
          textAlign: TextAlign.left,
          style: GoogleFonts.mulish(
              fontSize: size.width*0.04, fontWeight: FontWeight.w700, letterSpacing: -0.3),
        ),
      ),
    );
  }
}
