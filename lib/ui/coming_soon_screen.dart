import 'package:flutter/material.dart';

import '../constants.dart';

class ComingSoonScreen extends StatefulWidget {
  const ComingSoonScreen({Key? key}) : super(key: key);

  @override
  _ComingSoonScreenState createState() => _ComingSoonScreenState();
}

class _ComingSoonScreenState extends State<ComingSoonScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lab Simulation App',
          style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.height * 0.37,
              // width: size.width * 0.85,
              child: Image.asset(
                  "assets/images/under_construction.png"),
            ),
            SizedBox(height: size.height*0.07,),
            const Text(
              'Under \nConstruction',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500,color: Colors.black54,fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
