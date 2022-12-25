import 'package:flutter/material.dart';
import 'package:lab_simulation_app/constants.dart';

class AddToObservationBtn extends StatelessWidget {
  const AddToObservationBtn({Key? key, this.onPressed}) : super(key: key);
  final onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.01,
      ),
      child: SizedBox(
        height: size.height * 0.045,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor, elevation: 0),
          child: Text(
            "Add to Observation Table",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Poppins",
                letterSpacing: -0.6,
                fontSize: size.width * 0.04),
          ),
        ),
      ),
    );
  }
}

class AddToObservationBtnH extends StatelessWidget {
  const AddToObservationBtnH({Key? key, this.onPressed}) : super(key: key);
  final onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return SizedBox(
      width: size.width * 0.17,
      height: size.height * 0.085,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor, elevation: 0),
        child: Text(
          "Add to Observation Table",
          textAlign: TextAlign.center,
          style: TextStyle(
              wordSpacing: -0.6,
              color: Colors.white,
              fontFamily: "Poppins",
              letterSpacing: -0.6,
              fontSize: size.width * 0.015),
        ),
      ),
    );
  }
}
