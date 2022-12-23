import 'package:flutter/material.dart';
import 'package:lab_simulation_app/components/radial_painter.dart';
import 'package:lab_simulation_app/constants.dart';

class MyProgressArea extends StatelessWidget {
  const MyProgressArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: appPadding),
      child: Container(
        child: Column(
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
                          fontSize: size.width*0.05
                      ),
                    ),
                    SizedBox(height: size.height*0.02,),
                    Row(
                      children: [
                        Text(
                          'Done',
                          style: TextStyle(
                              color: textColor.withOpacity(0.5),
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              fontSize: size.width*0.03
                          ),
                        ),
                        SizedBox(
                          width: size.width*0.02,
                        ),
                        Icon(
                          Icons.circle,
                          color: kPrimaryColor,
                          size: size.height*0.02,
                        ),
                      ],
                    ),
                ],),
                SizedBox(width: size.width*0.24,),
                Container(
                  height: 230,
                  child: CustomPaint(
                    foregroundPainter: RadialPainter(
                      bgColor: textColor.withOpacity(0.1),
                      lineColor: kPrimaryColor,
                      percent: 0.33,
                      width: size.width*0.06,
                    ),
                    child: Center(
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
                SizedBox(width: size.width*0.19,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '66.7%',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                          fontSize: size.width*0.05
                      ),
                    ),
                    SizedBox(height: size.height*0.02,),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: textColor.withOpacity(0.2),
                          size: size.height*0.02,
                        ),
                        SizedBox(
                          width: size.width*0.02,
                        ),
                        Text(
                          'Not Done',
                          style: TextStyle(
                              color: textColor.withOpacity(0.5),
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              fontSize: size.width*0.03
                          ),
                        ),
                      ],
                    ),
                  ],),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
