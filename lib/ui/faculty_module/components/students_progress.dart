import 'package:flutter/material.dart';
import 'package:lab_simulation_app/components/radial_painter.dart';
import 'package:lab_simulation_app/constants.dart';

class StudentsProgressArea extends StatelessWidget {
  const StudentsProgressArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '33.3%',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: "Poppins",
                      fontSize: size.width * 0.04),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Icon(
                  Icons.circle,
                  color: kfmPrimaryColor,
                  size: size.height * 0.02,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  'Students who performed \nlab',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: textColor.withOpacity(0.5),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Poppins",
                      fontSize: size.width * 0.02),
                ),
              ],
            ),
            SizedBox(
              width: size.width * 0.1,
            ),
            SizedBox(
              height: size.width*0.1,
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                  bgColor: textColor.withOpacity(0.1),
                  lineColor: kfmPrimaryColor,
                  percent: 0.33,
                  width: size.width * 0.04,
                ),
                child: const Center(
                  child: Text(
                    '      ',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.13,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '66.7%',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: "Poppins",
                      fontSize: size.width * 0.04),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Icon(
                  Icons.circle,
                  color: textColor.withOpacity(0.2),
                  size: size.height * 0.02,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  'Students who didn’t \nperform lab',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: textColor.withOpacity(0.5),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Poppins",
                      fontSize: size.width * 0.02),
                ),
              ],
            ),            ],
        ),
      ],
    );
  }
}
