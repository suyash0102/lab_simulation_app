import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lab_simulation_app/components/add_to_observation_btn.dart';
import 'package:lab_simulation_app/components/circular_meter.dart';
import 'package:lab_simulation_app/components/common_divider.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/ui/labs/secondYear/EE/network-analysis/thevneis-theorem/thevneis-theorem-data.dart';
import 'package:lab_simulation_app/ui/quiz_module/screens/start_screen.dart';
import 'package:lab_simulation_app/ui/viva_voice_module/screens/viva_voice_instructions_page.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:toggle_switch/toggle_switch.dart';

class ThevneisTheoremScreen extends StatefulWidget {
  const ThevneisTheoremScreen({Key? key}) : super(key: key);

  @override
  _ThevneisTheoremScreenState createState() => _ThevneisTheoremScreenState();
}

class _ThevneisTheoremScreenState extends State<ThevneisTheoremScreen> {
  SizedBox zero() {
    return const SizedBox(
      height: 0,
    );
  }

  SfSliderTheme _activeSlider() {
    return SfSliderTheme(
        data: SfSliderThemeData(tooltipBackgroundColor: Colors.red),
        child: SfSlider.vertical(
          min: 1,
          max: 2000,
          onChanged: switchOn
              ? (dynamic values) {
                  setState(() {
                    r3 = values;
                    i=(vSupply/(r1+r2));
                    voc=r2*i;
                    rth=((r1*r2)/(r1+r2));
                    iLoad=((voc)/(rth+r3));
                  });
                }
              : null,
          value: switchOn ? r3 : 0,
          // enableTooltip: true,
          numberFormat: NumberFormat('#'),
        ));
  }

  bool addedToObservation = false;

  bool switchOn = false;
  double vSupply = 0.0;
  double r1 = 0.0;
  double r2 = 0.0;
  double r3 = 0.0;
  double i = 0.0;
  double rth = 0.0;
  double iLoad = 0.0;
  double voc = 0.0;

  int theoryIndex = 0;

  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                  iconTheme: const IconThemeData(color: Colors.white),
                  backgroundColor: kPrimaryColor,
                  centerTitle: true,
                  title: Text(
                    thevneisTitle,
                    style: const TextStyle(
                        fontFamily: 'Poppins', color: Colors.white),
                  ),
                  bottom: TabBar(
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.lightBlueAccent, Colors.purpleAccent],
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      indicatorColor: Colors.black,
                      tabs: const <Widget>[
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Procedure',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Simulation',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Center(
                              child: Text(
                                'Observation Table',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Center(
                              child: Text(
                                'Evaluation',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ])),
              body: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
                          ToggleSwitch(
                            customTextStyles: const [
                              TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              ),
                              TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                              )
                            ],
                            initialLabelIndex: theoryIndex,
                            totalSwitches: 2,
                            minWidth: size.width * 0.22,
                            labels: const ['Procedure', 'Theory'],
                            onToggle: (index) {
                              setState(() {
                                theoryIndex = index!;
                              });
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Container(
                            width: size.width * 0.9,
                            height: size.height * 0.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(size.width * 0.03),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Aim:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Poppins",
                                            fontSize: size.width * 0.05),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.04,
                                      ),
                                      Expanded(
                                        child: Text(
                                          thevneisAim,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              fontSize: size.width * 0.04,
                                              color: kPrimaryColor),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.005,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          theoryIndex == 0
                              ? Column(
                                  children: [
                                    Column(
                                      children: thevneisProcedure.map((strone) {
                                        return Row(children: [
                                          Text(
                                            "\u2022",
                                            style: TextStyle(
                                                fontSize: size.width * 0.07,
                                                fontFamily: 'Poppins'),
                                          ),
                                          //bullet text
                                          SizedBox(
                                            width: size.width * 0.03,
                                          ),
                                          //space between bullet and text
                                          Expanded(
                                            child: Text(
                                              strone,
                                              style: TextStyle(
                                                  fontSize: size.width * 0.04,
                                                  fontFamily: 'Poppins'),
                                            ), //text
                                          )
                                        ]);
                                      }).toList(),
                                    ),
                                    Text(
                                      'Calculations:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: size.width * 0.06,
                                          fontFamily: 'Poppins',
                                          color: kPrimaryColor),
                                    ),
                                    Text(
                                      thevneisCalculations,
                                      style: TextStyle(
                                          fontSize: size.width * 0.04,
                                          fontFamily: 'Poppins'),
                                    )
                                  ],
                                )
                              : Row(children: [
                                  Expanded(
                                    child: Text(
                                      thevneisTheory,
                                      style: TextStyle(
                                          fontSize: size.width * 0.04,
                                          fontFamily: 'Poppins'),
                                    ), //text
                                  )
                                ])
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.04,
                                  top: size.height * 0.01),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    player.play(
                                        AssetSource('audio/slide-click.wav'));
                                    switchOn = !switchOn;
                                    switchOn ? vSupply = 10 : null;
                                    switchOn ? r1 = 973 : r1 = 0;
                                    switchOn ? r2 = 2171 : r2 = 0;
                                  });
                                },
                                child: switchOn
                                    ? SizedBox(
                                        height: size.height * 0.055,
                                        child:
                                            Image.asset("assets/images/s1.png"))
                                    : SizedBox(
                                        height: size.height * 0.055,
                                        child: Image.asset(
                                            "assets/images/s0.png")),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: size.width * 0.03,
                                    left: size.width * 0.15),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      switchOn ? vSupply = 10 : null;
                                      switchOn ? r1 = 973 : r1 = 0;
                                      switchOn ? r2 = 2171 : r2 = 0;
                                    });
                                  },
                                  child: switchOn
                                      ? AddToObservationBtn(
                                          onPressed: () {
                                            setState(() {
                                              addedToObservation = true;
                                              voc = voc;
                                            });
                                          },
                                        )
                                      : Container(
                                          height: size.height * 0.030,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    top: size.height * 0.15,
                                    left: size.width * 0.85),
                                child:
                                    switchOn ? Text("Rl = ${r3.toInt()}") : const Text("0.0")),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: size.height * 0.11,
                                    left: size.width * 0.85),
                                child:
                                switchOn ? Text("R1 = ${r1.toInt()}") : const Text("0.0")),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: size.height * 0.13,
                                    left: size.width * 0.85),
                                child:
                                switchOn ? Text("R2 = ${r2.toInt()}") : const Text("0.0")),
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: size.height * 0.067,
                                        right: size.width * 0.025),
                                    child: SizedBox(
                                      height: size.height * 0.207,
                                      child: Image.asset(
                                          "assets/images/Thevenins-Theorem-1.png"),
                                    ),
                                  ),
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //       top: size.height * 0.02,
                            //       left: size.width * 0.41),
                            //   child: Container(
                            //       color: Colors.white,
                            //       height: size.height * 0.055,
                            //       width: size.width * 0.11,
                            //       child: CircularMeter(
                            //         showFirstLabel: true,
                            //         fontSizeM: 12,
                            //         showLabels: false,
                            //         fontSize: 0,
                            //         meterName: "A",
                            //         value: switchOn
                            //             ? roundDouble(i0, 1)
                            //             : 0.0,
                            //         range1: 0,
                            //         range2: 10,firstColorCut: 100, secondColorCut: 200,thirdColorCut: 300,)),
                            // ),
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //       top: size.height * 0.016,
                            //       left: size.width * 0.52),
                            //   child: Container(
                            //       color: Colors.white,
                            //       height: size.height * 0.055,
                            //       width: size.width * 0.11,
                            //       // width: 50,
                            //       child: CircularMeter(
                            //         showFirstLabel: true,
                            //         fontSizeM: 12,
                            //         showLabels: false,
                            //         fontSize: 0,
                            //         meterName: "W",
                            //         value: switchOn
                            //             ? roundDouble(W, 1)
                            //             : 0.0,
                            //         range1: 0,
                            //         range2: 300,firstColorCut: 100, secondColorCut: 200, thirdColorCut: 300,)),
                            // ),
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //       top: size.height * 0.16,
                            //       right: size.width * 0.02,
                            //       left: size.width * 0.91),
                            //   child: Container(
                            //       color: Colors.white,
                            //       height: size.height * 0.055,
                            //       width: size.width * 0.11,
                            //       // width: 50,
                            //       child: CircularMeter(
                            //         showFirstLabel: true,
                            //         fontSizeM: 12,
                            //         showLabels: false,
                            //         fontSize: 0,
                            //         meterName: "V2",
                            //         value: switchOn
                            //             ? roundDouble(v2, 1)
                            //             : 0.0,
                            //         range1: 0,
                            //         range2: 30,
                            //         firstColorCut: 100, secondColorCut: 200, thirdColorCut: 300,)),
                            // ),
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //       top: size.height * 0.16,
                            //       right: size.width * 0.11,
                            //       left: size.width * 0.69),
                            //   child: Container(
                            //       color: Colors.white,
                            //       height: size.height * 0.055,
                            //       width: size.width * 0.11,
                            //       // width: 50,
                            //       child: CircularMeter(
                            //         showFirstLabel: true,
                            //         fontSizeM: 12,
                            //         showLabels: false,
                            //         fontSize: 0,
                            //         meterName: "V1",
                            //         value: switchOn
                            //             ? roundDouble(v1, 1)
                            //             : 0.0,
                            //         range1: 0,
                            //         range2: 115,firstColorCut: 100, secondColorCut: 200, thirdColorCut: 300,)),
                            // ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: size.width * 0.57,
                                top: size.height * 0.061,
                              ),
                              child: _activeSlider(),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: size.width * 0.4),
                              child: Container(
                                  color: Colors.white,
                                  height: size.height * 0.195,
                                  width: size.width * 0.4,
                                  // width: 50,
                                  child: CircularMeter(
                                    showFirstLabel: false,
                                    showLabels: true,
                                    fontSizeM: size.width * 0.05,
                                    fontSize: size.width * 0.035,
                                    meterName: "RL",
                                    value: switchOn
                                        ? roundDouble(r3, 0)
                                        : 0.0,
                                    range1: 800,
                                    range2: 2000,firstColorCut: 1200, secondColorCut: 1600, thirdColorCut: 2000,)),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: size.height * 0.05,
                                    left: size.width * 0.45),
                                child:
                                switchOn ? Text("I = ${roundDouble(i, 2)}") : const Text("0.0")),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: size.height * 0.08,
                                    left: size.width * 0.45),
                                child:
                                switchOn ? Text("Rth = ${roundDouble(rth, 2)}") : const Text("0.0")),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: size.height * 0.11,
                                    left: size.width * 0.45),
                                child:
                                switchOn ? Text("I load = ${roundDouble(iLoad, 4)}") : const Text("0.0")),
                            // Padding(
                            //   padding: EdgeInsets.only(
                            //       left: size.width * 0.45),
                            //   child: Container(
                            //       color: Colors.white,
                            //       height: size.height * 0.195,
                            //       width: size.width * 0.4,
                            //       // width: 50,
                            //       child: CircularMeter(
                            //         showFirstLabel: true,
                            //         fontSizeM: size.width * 0.04,
                            //         showLabels: true,
                            //         fontSize: size.width * 0.04,
                            //         meterName: "A",
                            //         value: switchOn
                            //             ? roundDouble(i0, 1)
                            //             : 0.0,
                            //         range1: 0,
                            //         range2: 10,firstColorCut: 100, secondColorCut: 200, thirdColorCut: 300,)),
                            // ),
                          ],
                        ),
                      ],
                    )),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Text(
                          'Observation Table:',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              color: Colors.black,
                              fontSize: size.width * 0.055),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Table(
                          defaultColumnWidth:
                              FixedColumnWidth(size.width * 0.19),
                          border: TableBorder.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 2),
                          children: [
                            TableRow(children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(top: size.height * 0.015),
                                child: Tooltip(
                                  triggerMode: TooltipTriggerMode.tap,
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                      color: Colors.white,
                                      fontSize: size.width * 0.03),
                                  message: 'Serial No. of Observation',
                                  child: Text('Sr. No',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Poppins",
                                          color: kPrimaryColor,
                                          fontSize: size.width * 0.04)),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: size.height * 0.015),
                                child: Tooltip(
                                  triggerMode: TooltipTriggerMode.tap,
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                      color: Colors.white,
                                      fontSize: size.width * 0.03),
                                  message: 'Primary Voltage V1 (L.V. Side)',
                                  child: Text('Voc',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Poppins",
                                          color: kPrimaryColor,
                                          fontSize: size.width * 0.04)),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: size.height * 0.015),
                                child: Tooltip(
                                  triggerMode: TooltipTriggerMode.tap,
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                      color: Colors.white,
                                      fontSize: size.width * 0.03),
                                  message:
                                      'Primary Current I0 (L.V. Side) (Amp)',
                                  child: Text('Rth',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Poppins",
                                          color: kPrimaryColor,
                                          fontSize: size.width * 0.04)),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: size.height * 0.015),
                                child: Tooltip(
                                  triggerMode: TooltipTriggerMode.tap,
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                      color: Colors.white,
                                      fontSize: size.width * 0.03),
                                  message: 'Input Power Pi (L.V. Side) (Watt)',
                                  child: Text('I_Load',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Poppins",
                                          color: kPrimaryColor,
                                          fontSize: size.width * 0.04)),
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                '\n1\n',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: size.width * 0.035),
                              ),
                              voc == 0.0
                                  ? Text(
                                      "\n0.0 V",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Poppins",
                                          color: Colors.black,
                                          fontSize: size.width * 0.035),
                                    )
                                  : Text(
                                      "\n$voc V",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Poppins",
                                          color: Colors.black,
                                          fontSize: size.width * 0.035),
                                    ),
                              rth == 0.0
                                  ? Text(
                                      "\n0.0 Ohm",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Poppins",
                                          color: Colors.black,
                                          fontSize: size.width * 0.035),
                                    )
                                  : Text(
                                      "\n${roundDouble(rth, 2)} Ohm",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Poppins",
                                          color: Colors.black,
                                          fontSize: size.width * 0.035),
                                    ),
                              iLoad == 0.0
                                  ? Text(
                                      "\n0.0 A",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Poppins",
                                          color: Colors.black,
                                          fontSize: size.width * 0.035),
                                    )
                                  : Text(
                                      "\n${roundDouble(iLoad, 4)} A",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Poppins",
                                          color: Colors.black,
                                          fontSize: size.width * 0.035),
                                    ),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                      child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.25),
                        child: SizedBox(
                          height: size.height * 0.05,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return QuizScreen(
                                      title: thevneisTitle,
                                      optionOne: thevneisOptionOne,
                                      optionTwo: thevneisOptionTwo,
                                      optionThree: thevneisOptionThree,
                                      optionFour: thevneisOptionFour,
                                      questionsList: thevneisQuestionsList,
                                      experimentScreen:
                                          thevneisExperimentScreen,
                                      noOfQuestions: thevneisNoOfQuestions,
                                      correctAnswers: thevneisCorrectAnswers,
                                      quizTitle: thevneisAim,
                                    );
                                  },
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor, elevation: 0),
                            child: const Text(
                              "Take Quiz",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 21),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.25),
                        child: SizedBox(
                          height: size.height * 0.05,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return VivaVoiceInstructionsScreen(
                                      title: thevneisTitle,
                                      quizTitle: thevneisAim,
                                    );
                                  },
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor, elevation: 0),
                            child: const Text(
                              "Viva Voice",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 21),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            )));
  }
}

double roundDouble(double value, int places) {
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

class Zero extends StatelessWidget {
  const Zero({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 0,
    );
  }
}
