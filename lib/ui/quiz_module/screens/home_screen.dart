import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/ui/labs/secondYear/EE/machine/ocTest/oc_test.dart';
import 'package:lab_simulation_app/ui/quiz_module/components/choose_an_answer_box.dart';
import 'package:lab_simulation_app/ui/quiz_module/components/option_box.dart';
import 'package:lab_simulation_app/ui/quiz_module/components/question_answer_divider.dart';
import 'package:lab_simulation_app/ui/quiz_module/components/question_box.dart';
import 'package:lab_simulation_app/ui/quiz_module/components/question_mark_icon.dart';
import 'package:lab_simulation_app/ui/quiz_module/components/question_number_index.dart';
import 'package:lab_simulation_app/ui/quiz_module/controller/index_controller.dart';
import 'package:provider/provider.dart';
import 'result_screen.dart';

class FirstPage extends StatelessWidget {
  final String title;
  final List optionOne;
  final List optionTwo;
  final List optionThree;
  final List optionFour;
  final List questionsList;
  final Widget experimentScreen;
  final int noOfQuestions;
  int indexForQuestionNumber = 1;
  int selectedOption = 0;
  int marksObtainedFromCorrectAnswer = 0;

  FirstPage({super.key, required this.title, required this.optionOne, required this.optionTwo, required this.optionThree, required this.optionFour, required this.questionsList, required this.experimentScreen, required this.noOfQuestions});

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
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => OCTestScreen()));
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
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // leading: GestureDetector(child: Icon(Icons.close)),
          // automaticallyImplyLeading: true,
          toolbarHeight: size.height*0.07,
          backgroundColor: kPrimaryColor,
          title: Text(
            title,
            style: TextStyle(fontSize: size.width*0.05,color: Colors.white,fontFamily: "Poppins",)
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Quiz',
              style: GoogleFonts.mulish(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: size.width*0.06,
                letterSpacing: -0.3,
              ),
            ),
            Consumer<IndexController>(builder: (context, provider, child) {
              indexForQuestionNumber = provider.currentQuestionIndex;
              selectedOption = provider.optionSelected;
              return QuestionNumberIndex(
                questionNumber: indexForQuestionNumber,
              );
            }),
            Consumer<IndexController>(builder: (context, provider, child) {
              indexForQuestionNumber = provider.currentQuestionIndex;

              return QuestionBox(
                  question: questionsList[indexForQuestionNumber]);
            }),
            const DividerToDivideQuestionAndAnswer(),
            const QuestionMarkIcon(),
            const ChooseAnAnswerBox(),
            Consumer<IndexController>(builder: (context, provider, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OptionBox(
                    optionSelected: provider.optionSelected,
                    optionParameter: optionOne,
                    optionIndex: 'A.',
                    indexForQuestionNumber: provider.currentQuestionIndex,
                    providerIndexForOption: 1,
                  ),
                  OptionBox(
                    optionSelected: provider.optionSelected,
                    optionParameter: optionTwo,
                    optionIndex: 'B.',
                    indexForQuestionNumber: provider.currentQuestionIndex,
                    providerIndexForOption: 2,
                  ),
                  OptionBox(
                    optionSelected: provider.optionSelected,
                    optionParameter: optionThree,
                    optionIndex: 'C.',
                    indexForQuestionNumber: provider.currentQuestionIndex,
                    providerIndexForOption: 3,
                  ),
                  OptionBox(
                    optionSelected: provider.optionSelected,
                    optionParameter: optionFour,
                    optionIndex: 'D.',
                    indexForQuestionNumber: provider.currentQuestionIndex,
                    providerIndexForOption: 4,
                  ),
                  Consumer<IndexController>(
                      builder: (context, provider, child) {
                        indexForQuestionNumber = provider.currentQuestionIndex;
                        selectedOption = provider.optionSelected;

                        return selectedOption > 0
                            ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    height: 45,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            offset: Offset(1, 5),
                                            color:
                                            Color.fromRGBO(0, 0, 0, 0.25),
                                            blurRadius: 1.5,
                                            spreadRadius: 1,
                                          ),
                                          BoxShadow(
                                              offset: Offset(1, 2),
                                              color: Colors.white,
                                              blurRadius: 1,
                                              spreadRadius: 1)
                                        ]),
                                    child: ListTile(
                                      onTap: () {
                                        marksForCorrectAnswers();
                                        if (indexForQuestionNumber < 9) {
                                          provider.updateIndexForQuestion();
                                        } else {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ResultPage(
                                                      optionOne: optionOne,
                                                      optionTwo: optionTwo,
                                                      optionThree: optionThree,
                                                      optionFour: optionFour,
                                                      questionsList: questionsList,
                                                      marksEarnedFromQuiz:
                                                      marksObtainedFromCorrectAnswer, title: title, experimentScreen: const OCTestScreen(), noOfQuestions: noOfQuestions,
                                                    ),
                                              ));
                                        }
                                        provider.selectedOptionIndex(0);
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10)),
                                      tileColor: Colors.white,
                                      leading: Text(
                                        'Next',
                                        style: TextStyle(fontFamily: "Poppins", fontSize: size.width*0.04,fontWeight:FontWeight.w600,color: kPrimaryColor),
                                      ),
                                      title: const Padding(
                                        padding: EdgeInsets.only(
                                          right: 20,
                                          bottom: 5,
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                            : const SizedBox(
                          height: 65,
                        );
                      })
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  void marksForCorrectAnswers() {
    if (indexForQuestionNumber == 1) {
      if (selectedOption == 1) {
        marksObtainedFromCorrectAnswer++;
      }
    }
    if (indexForQuestionNumber == 2) {
      if (selectedOption == 3) {
        marksObtainedFromCorrectAnswer++;
      }
    }
    if (indexForQuestionNumber == 3) {
      if (selectedOption == 2) {
        marksObtainedFromCorrectAnswer++;
      }
    }
    if (indexForQuestionNumber == 4) {
      if (selectedOption == 2) {
        marksObtainedFromCorrectAnswer++;
      }
    }
    if (indexForQuestionNumber == 5) {
      if (selectedOption == 1) {
        marksObtainedFromCorrectAnswer++;
      }
    }
    if (indexForQuestionNumber == 6) {
      if (selectedOption == 4) {
        marksObtainedFromCorrectAnswer++;
      }
    }
    if (indexForQuestionNumber == 7) {
      if (selectedOption == 1) {
        marksObtainedFromCorrectAnswer++;
      }
    }
    if (indexForQuestionNumber == 8) {
      if (selectedOption == 3) {
        marksObtainedFromCorrectAnswer++;
      }
    }
    if (indexForQuestionNumber == 9) {
      if (selectedOption == 3) {
        marksObtainedFromCorrectAnswer++;
      }
    }
  }
}
