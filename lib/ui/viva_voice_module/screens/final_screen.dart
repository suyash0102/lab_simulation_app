import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/ui/auth/launcherScreen/launcher_screen.dart';
import 'package:lab_simulation_app/ui/quiz_module/components/question_answer_divider.dart';
import 'package:lab_simulation_app/ui/quiz_module/controller/index_controller.dart';
import 'package:provider/provider.dart';

class FinalScreen extends StatelessWidget {
  final String title;
  final String quizTitle;

  FinalScreen({
    super.key,
    required this.title,
    required this.quizTitle,
  });

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
              title: const Text(
                'Viva Voice',
                style: TextStyle(fontFamily: "Poppins"),
              ),
              content: const Text(
                'You Cannot go back!',
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
      child: Consumer<IndexController>(
          builder: (context, getIndexProvider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            toolbarHeight: size.height * 0.07,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height*0.04,),
              Center(
                child: Text(
                  'Viva Voice',
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: size.width * 0.07,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      letterSpacing: size.width * 0.005),
                ),
              ),
              SizedBox(height: size.height*0.06,),
              SizedBox(
                  width: size.width * 0.29,
                  height: size.height * 0.15,
                  child: Image.asset('assets/icons/mic.png')),
              SizedBox(height: size.height*0.03,),
              const DividerToDivideQuestionAndAnswer(),
              SizedBox(height: size.height*0.06,),
              Text(
                'Your Response is being evaluated',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Poppins',
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: size.width * 0.045,
                ),
              ),
              SizedBox(height: size.height*0.1,),
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
              SizedBox(
                height: size.height * 0.1,
              ),
              Text(
                'UI is under development',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  fontSize: size.width * 0.03,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
