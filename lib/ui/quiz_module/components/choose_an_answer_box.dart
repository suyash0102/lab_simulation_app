import 'package:flutter/material.dart';

class ChooseAnAnswerBox extends StatelessWidget {
  const ChooseAnAnswerBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.03,
      width: size.width * 0.4,
      child: Text(
        'Choose an answer',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: "Poppins",
            fontSize: size.width * 0.035,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF797979)),
      ),
    );
  }
}
