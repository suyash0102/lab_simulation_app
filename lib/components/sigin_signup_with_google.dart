import 'package:flutter/material.dart';

class SigninSinupGoogle extends StatefulWidget {
  const SigninSinupGoogle({Key? key, required this.text, this.onPress})
      : super(key: key);
  final String text;
  final Function? onPress;

  @override
  State<SigninSinupGoogle> createState() => _SigninSinupGoogleState();
}

class _SigninSinupGoogleState extends State<SigninSinupGoogle> {
// final Function onPressed;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return GestureDetector(
      onTap: widget.onPress as void Function()?,
      child: Container(
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.02,
            ),
            Container(
              child: Image.asset("assets/icons/google_icon.png"),
              height: size.height * 0.04,
            ),
            SizedBox(
              width: size.width * 0.15,
            ),
            Text(
              widget.text,
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF555555)),
            )
          ],
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF555555)),
          borderRadius: BorderRadius.circular(10),
        ),
        height: size.height * 0.06,
      ),
    );
  }
}
