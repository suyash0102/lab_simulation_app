import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/ui/quiz_module/components/choose_an_answer_box.dart';
import 'package:lab_simulation_app/ui/quiz_module/components/question_answer_divider.dart';
import 'package:lab_simulation_app/ui/quiz_module/components/question_mark_icon.dart';
import 'package:lab_simulation_app/ui/viva_voice_module/screens/final_screen.dart';

class QuestionScreen extends StatelessWidget {
  final String title;
  final String quizTitle;

  QuestionScreen({super.key, required this.title, required this.quizTitle});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              insetPadding: EdgeInsets.zero,
              contentTextStyle: GoogleFonts.mulish(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text('Opppsss'),
              content: const Text(
                'Sorry You Can\'t Go Back!',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('Continue'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // leading: GestureDetector(child: Icon(Icons.close)),
          // automaticallyImplyLeading: true,
          toolbarHeight: size.height * 0.07,
          backgroundColor: kPrimaryColor,
          title: Text(title,
              style: TextStyle(
                fontSize: size.width * 0.05,
                color: Colors.white,
                fontFamily: "Poppins",
              )),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Viva Voice',
                style: GoogleFonts.mulish(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: size.width * 0.06,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            SizedBox(
              height: size.height*0.02,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 8,
              child: Padding(
                padding: EdgeInsets.all(size.width * 0.02),
                child: SizedBox(
                  width: size.width * 0.7,
                  height: size.height * 0.17,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          height: size.height*0.05,
                          child: Text(
                            'What is the significance of O.C. Test?',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: size.width * 0.036,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height*0.02,
                      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color:kGreyColor,
                                  offset: Offset(1, 2),
                                  blurRadius: 1,
                                  spreadRadius: 2),
                            ],
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.mic,
                                color: kPrimaryColor,
                                size: size.width*0.08,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: size.height*0.01,
                      ),
                      Center(
                        child: Text(
                          'Start Recording',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.036,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height*0.05,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 8,
              child: Padding(
                padding: EdgeInsets.all(size.width * 0.02),
                child: SizedBox(
                  width: size.width * 0.7,
                  height: size.height * 0.17,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          height: size.height*0.05,
                          child: Text(
                            'What is the significance of O.C. Test?',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: size.width * 0.036,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height*0.02,
                      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color:kGreyColor,
                                  offset: Offset(1, 2),
                                  blurRadius: 1,
                                  spreadRadius: 2),
                            ],
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.mic,
                                color: kPrimaryColor,
                                size: size.width*0.08,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: size.height*0.01,
                      ),
                      Center(
                        child: Text(
                          'Start Recording',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.036,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height*0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.3),
              child: SizedBox(
                height: size.height * 0.05,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return FinalScreen( title: title, quizTitle: quizTitle);
                        },
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor, elevation: 0),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: size.width * 0.04),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
