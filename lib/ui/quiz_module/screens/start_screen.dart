import 'package:flutter/material.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/ui/labs/secondYear/EE/machine/ocTest/ocData.dart';
import 'package:lab_simulation_app/ui/quiz_module/components/question_answer_divider.dart';
import 'package:lab_simulation_app/ui/quiz_module/controller/index_controller.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

class QuizScreen extends StatelessWidget {
  final String title;
  final String quizTitle;
  final List optionOne;
  final List optionTwo;
  final List optionThree;
  final List optionFour;
  final List questionsList;
  final Widget experimentScreen;
  final int noOfQuestions;
  final List correctAnswers;

  const QuizScreen(
      {super.key,
      required this.title,
      required this.optionOne,
      required this.optionTwo,
      required this.optionThree,
      required this.optionFour,
      required this.questionsList,
      required this.experimentScreen,
      required this.noOfQuestions,
      required this.correctAnswers, required this.quizTitle});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<IndexController>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
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
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              SizedBox(
                  width: size.width * 0.5,
                  height: size.height * 0.2,
                  child: Image.asset('assets/icons/question_mark.png')),
              Text(
                'Quiz',
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: size.width * 0.07,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    letterSpacing: size.width * 0.005),
              ),
              const DividerToDivideQuestionAndAnswer(),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.03),
                child: Text(
                  quizTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: size.width * 0.04,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              GestureDetector(
                onTap: () {
                  provider.restartIndexForQuestion();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FirstPage(
                                experimentScreen: experimentScreen,
                                title: title,
                                optionOne: optionOne,
                                optionFour: optionFour,
                                optionThree: optionThree,
                                optionTwo: optionTwo,
                                questionsList: questionsList,
                                noOfQuestions: noOfQuestions,
                                correctAnswers: ocCorrectAnswers, quizTitle: quizTitle,
                              )));
                },
                child: Container(
                  width: size.width * 0.38,
                  height: size.height * 0.05,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(
                            1,
                            5.0,
                          ),
                          blurRadius: 1.5,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(2, 1),
                          blurRadius: 0,
                          spreadRadius: 0,
                        )
                      ]
                      //
                      ),
                  child: Center(
                      child: Text(
                    'Start Quiz',
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: size.width * 0.038,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w700,
                        letterSpacing: size.width * 0.005),
                  )),
                ),
              ),
              SizedBox(
                height: size.height * 0.07,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
                child: SizedBox(
                  height: size.height * 0.05,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor, elevation: 0),
                    child: Text(
                      "Go Back to Experiment",
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
    });
  }
}
