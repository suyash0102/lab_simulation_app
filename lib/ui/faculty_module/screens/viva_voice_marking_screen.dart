import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/ui/viva_voice_module/screens/final_screen.dart';

class VivaVoiceMarkingScreen extends StatefulWidget {
  // final String title;
  // final String quizTitle;

  VivaVoiceMarkingScreen({super.key, });

  @override
  State<VivaVoiceMarkingScreen> createState() => _VivaVoiceMarkingScreenState();
}

class _VivaVoiceMarkingScreenState extends State<VivaVoiceMarkingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: size.height * 0.07,
        backgroundColor: kfmPrimaryColor,
        title: Text("title",
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
                height: size.height * 0.23,
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
                            color: kfmPrimaryColor,
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
                      child: OutlinedButton(
                        onPressed: () {
                        },
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: kfmPrimaryColor),
                            shape: const StadiumBorder()),
                        child: Text(
                          'Give Score',
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: size.width * 0.04,
                              color: kfmPrimaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.01,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: size.width*0.03),
                        child: Text(
                          'Add Comment:',
                          style: GoogleFonts.mulish(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: size.width * 0.03,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.006,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                      child: SizedBox(
                        height: size.height*0.04,
                        child: TextField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            fillColor: kGreyColor,
                            enabledBorder:
                            const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.zero,
                                borderSide: BorderSide(
                                    color: Colors
                                        .transparent)),
                            hintText: 'Comment',
                            contentPadding:
                            EdgeInsets.symmetric(
                              horizontal: size.width * 0.05,
                            ),
                            border:
                            const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.zero,
                                borderSide: BorderSide(
                                    color:
                                    Colors.white)),
                            focusedBorder:
                            const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.zero,
                                borderSide: BorderSide(
                                    color: Colors
                                        .transparent)),
                            focusColor: Colors.black,
                          ),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: size.width * 0.04,
                              ),
                        ),
                      ),
                    )
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
                            color: kfmPrimaryColor,
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
                      child: OutlinedButton(
                        onPressed: () {
                        },
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: kfmPrimaryColor),
                            shape: const StadiumBorder()),
                        child: Text(
                          'Give Score',
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: size.width * 0.04,
                              color: kfmPrimaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.01,
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
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: kfmPrimaryColor, elevation: 0),
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
          SizedBox(
            height: size.height * 0.05,
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
  }
}
