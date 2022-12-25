import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/ui/auth/launcherScreen/launcher_screen.dart';
import 'package:lab_simulation_app/ui/labs/secondYear/EE/machine/ocTest/ocData.dart';
import 'package:lab_simulation_app/ui/quiz_module/controller/index_controller.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'start_screen.dart';

class ResultPage extends StatelessWidget {
  final String title;
  final List optionOne;
  final List optionTwo;
  final List optionThree;
  final List optionFour;
  final List questionsList;
  final Widget experimentScreen;
  final int noOfQuestions;
  final List correctAnswers;

  ResultPage({
    super.key,
    required this.marksEarnedFromQuiz,
    required this.title,
    required this.optionOne,
    required this.optionTwo,
    required this.optionThree,
    required this.optionFour,
    required this.questionsList,
    required this.experimentScreen,
    required this.noOfQuestions,
    required this.correctAnswers,
  });

  int marksEarnedFromQuiz = 0;

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
              title: const Text('Quit Quiz?'),
              content: const Text(
                'Are you sure you want exit quiz!',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil<void>(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const LauncherScreen()),
                      ModalRoute.withName('/'),
                    );
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Consumer<IndexController>(
          builder: (context, getIndexProvider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            toolbarHeight: size.height * 0.07,
            leading: marksEarnedFromQuiz > 4
                ? IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                insetPadding: EdgeInsets.zero,
                                contentTextStyle: GoogleFonts.mulish(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: const Text(
                                  'Back to home?',
                                ),
                                content: const Text(
                                  'Are you sure want to\nrestart the quiz',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text(
                                      'NO',
                                      style: TextStyle(color: kBlueColor),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => QuizScreen(
                                                  title: title,
                                                  optionOne: optionOne,
                                                  optionTwo: optionTwo,
                                                  optionThree: optionThree,
                                                  optionFour: optionFour,
                                                  questionsList: questionsList,
                                                  experimentScreen:
                                                      experimentScreen,
                                                  noOfQuestions: noOfQuestions,
                                                  correctAnswers:
                                                      correctAnswers,
                                                ))),
                                    child: const Text(
                                      'YES',
                                      style: TextStyle(color: kBlueColor),
                                    ),
                                  ),
                                ],
                              ));
                    },
                  )
                : const SizedBox(),
            centerTitle: true,
            title: Text(title,
                style: TextStyle(
                  fontSize: size.width * 0.05,
                  color: Colors.white,
                  fontFamily: "Poppins",
                )),
            elevation: 0,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Quiz Result',
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: size.width * 0.07,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    letterSpacing: size.width * 0.005),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.09,
                    height: size.height * 0.2,
                    child: CircularPercentIndicator(
                      backgroundColor: const Color.fromRGBO(230, 230, 230, 1),
                      animation: true,
                      radius: size.width * 0.18,
                      lineWidth: size.width * 0.04,
                      percent: marksEarnedFromQuiz / noOfQuestions,
                      animationDuration: 2000,
                      reverse: false,
                      circularStrokeCap: CircularStrokeCap.square,
                      center: Text(
                        '$marksEarnedFromQuiz/$noOfQuestions',
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: size.width * 0.038,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            letterSpacing: size.width * 0.005),
                      ),
                      progressColor:
                          marksEarnedFromQuiz > 4 ? kGreenColor : kRedColor,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      marksEarnedFromQuiz < 5
                          ? Container(
                              width: size.width * 0.33,
                              height: size.height * 0.045,
                              decoration: BoxDecoration(
                                color: kRedColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text('Ooops...!',
                                    style: TextStyle(
                                        fontSize: size.width * 0.04,
                                        color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w600)),
                              ),
                            )
                          : Container(
                              width: size.width * 0.33,
                              height: size.height * 0.045,
                              decoration: BoxDecoration(
                                color: kGreenColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                  child: Text('Awesome!',
                                      style: TextStyle(
                                          fontSize: size.width * 0.04,
                                          color: Colors.white,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w600))),
                            ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      marksEarnedFromQuiz < 5
                          ? Padding(
                              padding: const EdgeInsets.only(
                                top: 23,
                              ),
                              child: Container(
                                width: 160,
                                height: 37,
                                color: Colors.white,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => QuizScreen(
                                                  title: title,
                                                  optionOne: optionOne,
                                                  optionTwo: optionTwo,
                                                  optionThree: optionThree,
                                                  optionFour: optionFour,
                                                  questionsList: questionsList,
                                                  experimentScreen:
                                                      experimentScreen,
                                                  noOfQuestions: noOfQuestions,
                                                  correctAnswers:
                                                      ocCorrectAnswers,
                                                )));
                                  },
                                  child: Text(
                                    'Try Again',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      decoration: TextDecoration.underline,
                                      color: kBlueColor,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.3,
                                      fontSize: size.width * 0.04,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                top: 23,
                              ),
                              child: Container(
                                width: 160,
                                height: 60,
                                color: Colors.white,
                                child: Text(
                                  'Congratulations\n You Passed the exam',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.mulish(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.3,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.18),
                    child: SizedBox(
                      height: size.height * 0.05,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil<void>(
                            context,
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const LauncherScreen()),
                            ModalRoute.withName('/'),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor, elevation: 0),
                        child: Text(
                          "Go Back to Home Screen",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: size.width * 0.04),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
