import 'package:flutter/cupertino.dart';
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
          children: const [
            Text(
              'Coming Soon...',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700,color: kPrimaryColor,fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
