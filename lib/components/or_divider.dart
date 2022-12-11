import 'package:flutter/material.dart';
import 'package:lab_simulation_app/constants.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          buildDivider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Or",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  fontFamily: "Poppins"
              ),
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return const Expanded(
      child: Divider(
        thickness: 1.5,
        color: Color(0xFF000000),
        height: 3,
      ),
    );
  }
}