import 'package:flutter/material.dart';

class QuestionMarkIcon extends StatelessWidget {
  const QuestionMarkIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Image.asset(
        'assets/icons/question_mark.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
