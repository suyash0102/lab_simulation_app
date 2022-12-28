import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lab_simulation_app/components/add_to_observation_btn.dart';
import 'package:lab_simulation_app/components/circular_meter.dart';
import 'package:lab_simulation_app/components/common_divider.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/ui/labs/secondYear/EE/machine/scTest/scData.dart';
import 'package:lab_simulation_app/ui/quiz_module/screens/start_screen.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:toggle_switch/toggle_switch.dart';

class SCTestScreen extends StatefulWidget {
  const SCTestScreen({Key? key}) : super(key: key);

  @override
  _SCTestScreenState createState() => _SCTestScreenState();
}

class _SCTestScreenState extends State<SCTestScreen> {
  SfSliderTheme _activeSlider() {
    return SfSliderTheme(
        data: SfSliderThemeData(tooltipBackgroundColor: Colors.red),
        child: SfSlider.vertical(
          min: 1.0,
          max: 20.0,
          // onChanged: null,
          onChanged: switchOn
              ? (dynamic values) {
                  setState(() {
                    vsc = values;
                    vsc = roundDouble(vsc, 1);
                    i0 = (vsc / zsc);
                    W = pow(i0, 2) * rsc;
                  });
                }
              : null,
          value: switchOn ? vsc : 0,
          // enableTooltip: true,
          numberFormat: NumberFormat('#'),
        ));
  }

  void _onEquivalentResistanceChanged(String value) {
    setState(() {
      equivalentResistanceByUser = double.parse(value);
    });
  }
  void _onEquivalentImpedanceChanged(String value) {
    setState(() {
      equivalentImpedanceByUser = double.parse(value);
    });
  }

  void _onEquivalentLeakageReactanceChanged(String value) {
    setState(() {
      equivalentLeakageReactanceByUser = double.parse(value);
    });
  }

  bool switchOn = false;
  double v1 = 0.0;
  double vsc = 10.0;
  double rsc = 4.41;
  double zsc = 4.6;
  double im = 0.0;
  double r0 = 623.711;
  double x0 = 96.688;
  double iw = 0.0;
  double phi = 0.0;
  double i0 = 0.0;
  double W = 0.0;
  double v2 = 0.0;


  double vSco = 0.0;
  double iSco = 0.0;
  double wSco = 0.0;
  double v2o = 0.0;
  double phio = 0.0;

  bool correctEquivalentResistanceValueEntered = false;
  bool correctEquivalentImpedanceValueEntered = false;
  bool correctEquivalentLeakageReactanceValueEntered = false;

  bool equivalentResistanceValueEntered = false;
  bool equivalentImpedanceValueEntered = false;
  bool equivalentLeakageReactanceValueEntered = false;


  bool addedToObservation = false;

  double equivalentResistanceByUser = 0.0;
  double equivalentImpedanceByUser = 0.0;
  double equivalentLeakageReactanceByUser = 0.0;


  double equivalentResistanceAnswer = 0.0;
  double equivalentImpedanceAnswer = 0.0;
  double equivalentLeakageReactanceAnswer = 0.0;


  int theoryIndex = 0;

  List<double> fieldOne = [];
  List<double> fieldTwo = [];
  List<double> fieldThree = [];
  List<double> fieldFour = [];

  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return SafeArea(
        child: DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                  iconTheme: const IconThemeData(color: Colors.white),
                  backgroundColor: kPrimaryColor,
                  centerTitle: true,
                  title: Text(
                    scTitle,
                    style:
                        const TextStyle(fontFamily: 'Poppins', color: Colors.white),
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
                                          scAim,
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
                                      children: scProcedure.map((strone) {
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
                                      scCalculations,
                                      style: TextStyle(
                                          fontSize: size.width * 0.04,
                                          fontFamily: 'Poppins'),
                                    )
                                  ],
                                )
                              : Row(children: [
                                  Expanded(
                                    child: Text(
                                      scTheory,
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
                      child: orientation == Orientation.portrait
                          ? Column(
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
                                            player.play(AssetSource(
                                                'audio/slide-click.wav'));
                                            switchOn = !switchOn;
                                            switchOn ? v1 = 20 : null;
                                            switchOn ? i0 : i0 = 0;
                                            switchOn ? W : W = 0;
                                            switchOn ? v2 : v2 = 0;
                                            i0 = (vsc / zsc);
                                            W = pow(i0, 2) * rsc;
                                          });
                                        },
                                        child: switchOn
                                            ? SizedBox(
                                                height: size.height * 0.055,
                                                child: Image.asset(
                                                    "assets/images/s1.png"))
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
                                              switchOn ? v1 = 230 : null;
                                              switchOn ? i0 : i0 = 0;
                                              switchOn ? W : W = 0;
                                              switchOn ? v2 : v2 = 0;
                                            });
                                          },
                                          child: switchOn
                                              ? AddToObservationBtn(
                                            onPressed: () {
                                              setState(() {
                                                addedToObservation = true;
                                                vSco = v1;
                                                iSco = i0;
                                                wSco = W;
                                                v2o = v2;
                                                // noLoadPowerFactorAnswer =
                                                //     roundDouble(
                                                //         roundDouble(
                                                //             wo, 2) /
                                                //             (v1o *
                                                //                 roundDouble(
                                                //                     i0o,
                                                //                     2)),
                                                //         3);
                                                // phio = acos(
                                                //     noLoadPowerFactorAnswer);
                                                // magnetizingComponentAnswer =
                                                //     roundDouble(
                                                //         roundDouble(
                                                //             i0o, 2) *
                                                //             sin(phio),
                                                //         3);
                                                // coreLossComponentAnswer =
                                                //     roundDouble(
                                                //         roundDouble(
                                                //             i0o, 2) *
                                                //             cos(phio),
                                                //         3);
                                                // resistanceAnswer =
                                                //     roundDouble(
                                                //         v1o /
                                                //             coreLossComponentAnswer,
                                                //         3);
                                                // magnetizingBranchReactanceAnswer =
                                                //     roundDouble(
                                                //         v1o /
                                                //             magnetizingComponentAnswer,
                                                //         3);
                                                // print(
                                                //     ' $V1 $I0 $W $noLoadPowerFactorAnswer');
                                                // print(
                                                //     ' $phio $magnetizingComponentAnswer');
                                                // print(
                                                //     ' $phio $coreLossComponentAnswer');
                                                // print(
                                                //     ' $phio $resistanceAnswer');
                                                // print(
                                                //     ' $phio $magnetizingBranchReactanceAnswer');
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
                                            top: size.height * 0.065,
                                            left: size.width * 0.098),
                                        child: switchOn
                                            ? Text("$vsc")
                                            : const Text("0.0")),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.065,
                                            left: size.width * 0.025),
                                        child: const Text("Vsc=")),
                                    switchOn
                                        ? Padding(
                                            padding: EdgeInsets.only(
                                                top: size.height * 0.067,
                                                right: size.width * 0.025),
                                            child: SizedBox(
                                              height: size.height * 0.207,
                                              child: Image.asset(
                                                  "assets/images/short_circuit_1.png"),
                                            ),
                                          )
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                top: size.height * 0.067,
                                                right: size.width * 0.027),
                                            child: SizedBox(
                                              height: size.height * 0.207,
                                              child: Image.asset(
                                                  "assets/images/short_circuit_0.png"),
                                            ),
                                          ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.02,
                                          left: size.width * 0.41),
                                      child: Container(
                                          color: Colors.white,
                                          height: size.height * 0.055,
                                          width: size.width * 0.11,
                                          child: CircularMeter(
                                              showFirstLabel: true,
                                              fontSizeM: 12,
                                              showLabels: false,
                                              fontSize: 0,
                                              meterName: "A",
                                              value: switchOn
                                                  ? roundDouble(i0, 1)
                                                  : 0.0,
                                              range1: 0,
                                              range2: 10,firstColorCut: 100, secondColorCut: 200, thirdColorCut: 300,)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.016,
                                          left: size.width * 0.52),
                                      child: Container(
                                          color: Colors.white,
                                          height: size.height * 0.055,
                                          width: size.width * 0.11,
                                          // width: 50,
                                          child: CircularMeter(
                                              showFirstLabel: true,
                                              fontSizeM: 12,
                                              showLabels: false,
                                              fontSize: 0,
                                              meterName: "W",
                                              value: switchOn
                                                  ? roundDouble(W, 1)
                                                  : 0.0,
                                              range1: 0,
                                              range2: 30,firstColorCut: 100, secondColorCut: 200, thirdColorCut: 300,)),
                                    ),
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
                                    //           showFirstLabel: true,
                                    //           fontSizeM: 12,
                                    //           showLabels: false,
                                    //           fontSize: 0,
                                    //           meterName: "V2",
                                    //           value: switchOn
                                    //               ? roundDouble(V2, 1)
                                    //               : 0.0,
                                    //           range1: 0,
                                    //           range2: 300)),
                                    // ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.16,
                                          right: size.width * 0.11,
                                          left: size.width * 0.69),
                                      child: Container(
                                          color: Colors.white,
                                          height: size.height * 0.055,
                                          width: size.width * 0.11,
                                          // width: 50,
                                          child: CircularMeter(
                                              showFirstLabel: true,
                                              fontSizeM: 12,
                                              showLabels: false,
                                              fontSize: 0,
                                              meterName: "Vsc",
                                              value: switchOn
                                                  ? roundDouble(vsc, 1)
                                                  : 0.0,
                                              range1: 0,
                                              range2: 25,firstColorCut: 100, secondColorCut: 200, thirdColorCut: 300,)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: size.width * 0.87,
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
                                              showFirstLabel: true,
                                              showLabels: true,
                                              fontSizeM: size.width * 0.04,
                                              fontSize: size.width * 0.04,
                                              meterName: "Vsc",
                                              value: switchOn
                                                  ? roundDouble(vsc, 1)
                                                  : 0.0,
                                              range1: 0,
                                              range2: 30,firstColorCut: 100, secondColorCut: 200, thirdColorCut: 300,)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.45),
                                      child: Container(
                                          color: Colors.white,
                                          height: size.height * 0.195,
                                          width: size.width * 0.4,
                                          // width: 50,
                                          child: CircularMeter(
                                              showFirstLabel: true,
                                              fontSizeM: size.width * 0.04,
                                              showLabels: true,
                                              fontSize: size.width * 0.04,
                                              meterName: "A",
                                              value: switchOn
                                                  ? roundDouble(i0, 1)
                                                  : 0.0,
                                              range1: 0,
                                              range2: 10,firstColorCut: 100, secondColorCut: 200, thirdColorCut: 300,)),
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: size.width * 0.0),
                                      child: Container(
                                          color: Colors.white,
                                          height: size.height * 0.195,
                                          width: size.width * 0.4,
                                          // width: 50,
                                          child: CircularMeter(
                                              showFirstLabel: true,
                                              fontSizeM: size.width * 0.04,
                                              showLabels: true,
                                              fontSize: size.width * 0.04,
                                              meterName: "W",
                                              value: switchOn
                                                  ? roundDouble(W, 1)
                                                  : 0.0,
                                              range1: 0,
                                              range2: 30,firstColorCut: 100, secondColorCut: 200, thirdColorCut: 300,)),
                                    ),
                                    // Padding(
                                    //   padding: EdgeInsets.only(
                                    //       left: size.width * 0.45),
                                    //   child: Container(
                                    //       color: Colors.white,
                                    //       height: size.height * 0.195,
                                    //       width: size.width * 0.4,
                                    //       child: CircularMeter(
                                    //           showFirstLabel: true,
                                    //           fontSizeM: size.width * 0.04,
                                    //           showLabels: true,
                                    //           fontSize: size.width * 0.04,
                                    //           meterName: "V2",
                                    //           value: switchOn
                                    //               ? roundDouble(V2, 1)
                                    //               : 0.0,
                                    //           range1: 0,
                                    //           range2: 300)),
                                    // ),
                                  ],
                                ),
                                const Text("Transformer Rating: 500kVA 115/230"),
                              ],
                            )
                          : Row(
                              children: [
                                // Stack(
                                //   children: [
                                //     Padding(
                                //       padding: EdgeInsets.only(
                                //           left: size.width * 0.455),
                                //       child: Container(
                                //           color: Colors.white,
                                //           height: size.height * 0.11,
                                //           width: size.width * 0.039,
                                //           // width: 50,
                                //           child: CircularMeter(
                                //               showFirstLabel: true,
                                //               fontSizeM: size.width * 0.01,
                                //               showLabels: false,
                                //               fontSize: 0,
                                //               meterName: "W",
                                //               value: switchOn
                                //                   ? roundDouble(W, 1)
                                //                   : 0.0,
                                //               range1: 0,
                                //               range2: 30,firstColorCut: 100, secondColorCut: 200, thirdColorCut: 300,)),
                                //     ),
                                //     switchOn
                                //         ? Padding(
                                //             padding: EdgeInsets.only(
                                //               top: size.height * 0.06,
                                //             ),
                                //             child: SizedBox(
                                //               height: size.height * 0.65,
                                //               width: size.width * 0.72,
                                //               child: Image.asset(
                                //                   "assets/images/short_circuit_1.png"),
                                //             ),
                                //           )
                                //         : Padding(
                                //             padding: EdgeInsets.only(
                                //               top: size.height * 0.06,
                                //             ),
                                //             child: SizedBox(
                                //               height: size.height * 0.65,
                                //               width: size.width * 0.72,
                                //               child: Image.asset(
                                //                   "assets/images/short_circuit_0.png"),
                                //             ),
                                //           ),
                                //     Padding(
                                //       padding: EdgeInsets.only(
                                //           top: size.height * 0.02,
                                //           left: size.width * 0.32),
                                //       child: Container(
                                //           color: Colors.white,
                                //           height: size.height * 0.15,
                                //           width: size.width * 0.05,
                                //           child: CircularMeter(
                                //               showFirstLabel: true,
                                //               fontSizeM: size.width * 0.015,
                                //               showLabels: false,
                                //               fontSize: 0,
                                //               meterName: "A",
                                //               value: switchOn
                                //                   ? roundDouble(i0, 1)
                                //                   : 0.0,
                                //               range1: 0,
                                //               range2: 10,firstColorCut: 100, secondColorCut: 200, thirdColorCut: 300,)),
                                //     ),
                                //     Padding(
                                //       padding: EdgeInsets.only(
                                //           top: size.height * 0.37,
                                //           left: size.width * 0.53),
                                //       child: Container(
                                //           color: Colors.white,
                                //           height: size.height * 0.15,
                                //           width: size.width * 0.05,
                                //           child: CircularMeter(
                                //               showFirstLabel: true,
                                //               fontSizeM: size.width * 0.015,
                                //               showLabels: false,
                                //               fontSize: 0,
                                //               meterName: "Vsc",
                                //               value: switchOn
                                //                   ? roundDouble(vsc, 1)
                                //                   : 0.0,
                                //               range1: 0,
                                //               range2: 25,firstColorCut: 100, secondColorCut: 200,thirdColorCut: 300,)),
                                //     ),
                                //     // Padding(
                                //     //   padding: EdgeInsets.only(
                                //     //       top: size.height * 0.37,
                                //     //       left: size.width * 0.672),
                                //     //   child: Container(
                                //     //       color: Colors.white,
                                //     //       height: size.height * 0.15,
                                //     //       width: size.width * 0.05,
                                //     //       child: CircularMeter(
                                //     //           showFirstLabel: true,
                                //     //           fontSizeM: size.width * 0.015,
                                //     //           showLabels: false,
                                //     //           fontSize: 0,
                                //     //           meterName: "V2",
                                //     //           value: switchOn
                                //     //               ? roundDouble(V2, 1)
                                //     //               : 0.0,
                                //     //           range1: 0,
                                //     //           range2: 300)),
                                //     // ),
                                //     Padding(
                                //       padding: EdgeInsets.only(
                                //         left: size.width * 0.02,
                                //         top: size.height * 0.15,
                                //       ),
                                //       child: _activeSlider(),
                                //     ),
                                //     Padding(
                                //         padding: EdgeInsets.only(
                                //             top: size.height * 0.052,
                                //             left: size.width * 0.063),
                                //         child: switchOn
                                //             ? Text("$vsc")
                                //             : const Text("0.0")),
                                //     Padding(
                                //         padding: EdgeInsets.only(
                                //             top: size.height * 0.052,
                                //             left: size.width * 0.03),
                                //         child: const Text("Vsc=")),
                                //   ],
                                // ),
                                // Column(
                                //   children: [
                                //     Row(
                                //       children: [
                                //         Padding(
                                //           padding: EdgeInsets.only(
                                //               top: size.height * 0.02),
                                //           child: GestureDetector(
                                //             onTap: () {
                                //               setState(() {
                                //                 switchOn = !switchOn;
                                //                 switchOn ? vsc = 230.0 : null;
                                //                 switchOn ? i0 : i0 = 0;
                                //                 switchOn ? W : W = 0;
                                //                 switchOn ? v2 : v2 = 0;
                                //                 i0 = (vsc / zsc);
                                //                 W = pow(i0, 2) * rsc;
                                //               });
                                //             },
                                //             child: switchOn
                                //                 ? SizedBox(
                                //                     height: size.height * 0.09,
                                //                     child: Image.asset(
                                //                         "assets/images/s1.png"))
                                //                 : Padding(
                                //                     padding: EdgeInsets.only(
                                //                         right:
                                //                             size.width * 0.14),
                                //                     child: SizedBox(
                                //                         height:
                                //                             size.height * 0.09,
                                //                         child: Image.asset(
                                //                             "assets/images/s0.png")),
                                //                   ),
                                //           ),
                                //         ),
                                //         Padding(
                                //           padding: EdgeInsets.only(
                                //               left: size.width * 0.035,
                                //               top: size.height * 0.02),
                                //           child: GestureDetector(
                                //             onTap: () {
                                //               setState(() {
                                //                 switchOn ? v1 : v1 = 0;
                                //                 switchOn ? i0 : i0 = 0;
                                //                 switchOn ? W : W = 0;
                                //                 switchOn ? v2 : v2 = 0;
                                //                 // Toggle light when tapped.
                                //               });
                                //             },
                                //             child: switchOn
                                //                 ? GestureDetector(
                                //                     onTap: () {
                                //                       setState(() {
                                //                         fieldOne.add(v1);
                                //                         fieldTwo.add(i0);
                                //                         fieldThree.add(W);
                                //                         fieldFour.add(v2);
                                //                       });
                                //                     },
                                //                     child: Container(
                                //                         decoration:
                                //                             BoxDecoration(
                                //                           color: Colors.grey,
                                //                           border: Border.all(
                                //                             width: 2,
                                //                           ),
                                //                           borderRadius:
                                //                               BorderRadius
                                //                                   .circular(12),
                                //                         ),
                                //                         height:
                                //                             size.height * 0.09,
                                //                         width:
                                //                             size.width * 0.14,
                                //                         child: const Center(
                                //                             child: Text(
                                //                           "Add to Observation Table",
                                //                           textAlign:
                                //                               TextAlign.center,
                                //                         ))),
                                //                   )
                                //                 : Container(
                                //                     height: size.height * 0.020,
                                //                   ),
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //     Stack(
                                //       children: [
                                //         Padding(
                                //           padding: EdgeInsets.only(
                                //               left: size.width * 0.02,
                                //               right: size.width * 0.04),
                                //           child: Container(
                                //               color: Colors.white,
                                //               height: size.height * 0.3,
                                //               width: size.width * 0.12,
                                //               child: CircularMeter(
                                //                   showFirstLabel: false,
                                //                   showLabels: true,
                                //                   fontSizeM: size.width * 0.02,
                                //                   fontSize: size.width * 0.017,
                                //                   meterName: "Vsc",
                                //                   value: switchOn
                                //                       ? roundDouble(vsc, 1)
                                //                       : 0.0,
                                //                   range1: 0,
                                //                   range2: 30,firstColorCut: 100, secondColorCut: 200, thirdColorCut: 300,)),
                                //         ),
                                //         Padding(
                                //           padding: EdgeInsets.only(
                                //               left: size.width * 0.15),
                                //           child: Container(
                                //               color: Colors.white,
                                //               height: size.height * 0.3,
                                //               width: size.width * 0.12,
                                //               child: CircularMeter(
                                //                   showFirstLabel: true,
                                //                   fontSizeM: size.width * 0.02,
                                //                   fontSize: size.width * 0.017,
                                //                   showLabels: true,
                                //                   meterName: "A",
                                //                   value: switchOn
                                //                       ? roundDouble(i0, 1)
                                //                       : 0.0,
                                //                   range1: 0,
                                //                   range2: 10,firstColorCut: 100, secondColorCut: 200, thirdColorCut: 300,)),
                                //         ),
                                //       ],
                                //     ),
                                //     Stack(
                                //       children: [
                                //         Padding(
                                //           padding: EdgeInsets.only(
                                //               left: size.width * 0.02,
                                //               right: size.width * 0.04),
                                //           child: Container(
                                //               color: Colors.white,
                                //               height: size.height * 0.3,
                                //               width: size.width * 0.12,
                                //               child: CircularMeter(
                                //                   showFirstLabel: false,
                                //                   showLabels: true,
                                //                   fontSizeM: size.width * 0.02,
                                //                   fontSize: size.width * 0.017,
                                //                   meterName: "W",
                                //                   value: switchOn
                                //                       ? roundDouble(W, 1)
                                //                       : 0.0,
                                //                   range1: 0,
                                //                   range2: 30,firstColorCut: 100, secondColorCut: 200, thirdColorCut: 300,)),
                                //         ),
                                //         // Padding(
                                //         //   padding: EdgeInsets.only(
                                //         //       left: size.width * 0.15),
                                //         //   child: Container(
                                //         //       color: Colors.white,
                                //         //       height: size.height * 0.3,
                                //         //       width: size.width * 0.12,
                                //         //       child: CircularMeter(
                                //         //           showFirstLabel: true,
                                //         //           fontSizeM: size.width * 0.02,
                                //         //           fontSize: size.width * 0.017,
                                //         //           showLabels: true,
                                //         //           meterName: "V2",
                                //         //           value: switchOn
                                //         //               ? roundDouble(V2, 1)
                                //         //               : 0.0,
                                //         //           range1: 0,
                                //         //           range2: 300)),
                                //         // ),
                                //       ],
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                    ),
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
                                  child: Text('Vsc',
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
                                  child: Text('Isc\n',
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
                                  'Input Power Pi (L.V. Side) (Watt)',
                                  child: Text('Wsc',
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
                              vSco == 0.0
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
                                "\n$vSco V",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: size.width * 0.035),
                              ),
                              iSco == 0.0
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
                                "\n${roundDouble(iSco, 2)} A",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: size.width * 0.035),
                              ),
                              wSco == 0.0
                                  ? Text(
                                "\n0.0 W",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: size.width * 0.035),
                              )
                                  : Text(
                                "\n${roundDouble(wSco, 2)} W",
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
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        addedToObservation == true
                            ? Text(
                          "From the Observation Table Given Above:",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.bold),
                        )
                            : Text(
                          "Add to Observation from Simulation Screen to check Calculations",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: kRedColor,
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.all(size.width * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              addedToObservation == true
                                  ? Text(
                                "1. Calculate the value of Equivalent resistance referred to HV side:",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    letterSpacing: -0.6,
                                    fontSize: size.width * 0.035),
                              )
                                  : const Zero(),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              addedToObservation == true
                                  ? Text(
                                "Equivalent resistance referred to HV side, R01 = Wsc/ Isc^2",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    letterSpacing: -0.6,
                                    fontSize: size.width * 0.035),
                              )
                                  : const Zero(),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              addedToObservation == true
                                  ? Row(
                                children: [
                                  Text(
                                    "R01 = ",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: size.width * 0.04,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.3,
                                    height: size.height * 0.04,
                                    child: TextField(
                                      autofocus: false,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        enabledBorder:
                                        const OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.zero,
                                            borderSide: BorderSide(
                                                color: Colors
                                                    .transparent)),
                                        contentPadding:
                                        EdgeInsets.symmetric(
                                          horizontal: size.width * 0.02,
                                        ),
                                        fillColor:
                                        equivalentResistanceValueEntered
                                            ? correctEquivalentResistanceValueEntered
                                            ? kGreenColor
                                            : kRedColor
                                            : kGreyColor,
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
                                        hintText:
                                        equivalentResistanceValueEntered
                                            ? "$equivalentResistanceByUser"
                                            : '0.0',
                                        hintStyle: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: size.width * 0.04,
                                            color:
                                            equivalentResistanceValueEntered
                                                ? kWhiteColor
                                                : kBlackColor),
                                      ),
                                      keyboardType:
                                      TextInputType.number,
                                      onChanged:
                                      _onEquivalentResistanceChanged,
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: size.width * 0.04,
                                          color:
                                          equivalentResistanceValueEntered
                                              ? kWhiteColor
                                              : kBlackColor),
                                      readOnly:
                                      equivalentResistanceValueEntered,
                                    ),
                                  ),
                                ],
                              )
                                  : const Zero(),
                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              equivalentResistanceValueEntered == true
                                  ? Text(
                                "The Correct Answer is: $equivalentResistanceAnswer Ohms",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: size.width * 0.04,
                                    color: const Color(0xFF31B565)),
                              )
                                  : SizedBox(
                                width: size.width * 0.02,
                              ),
                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              addedToObservation == true
                                  ? const CommonDivider()
                                  : const Zero(),
                              addedToObservation == true
                                  ? Text(
                                "2. Calculate the value of Equivalent impedance referred to HV side:",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    letterSpacing: -0.6,
                                    fontSize: size.width * 0.035),
                              )
                                  : const Zero(),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              addedToObservation == true
                                  ? Text(
                                "Equivalent impedance referred to HV side, Z01 = Vsc / Isc",
                                style: TextStyle(
                                    letterSpacing: -0.6,
                                    fontFamily: "Poppins",
                                    fontSize: size.width * 0.035),
                              )
                                  : const Zero(),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              addedToObservation == true
                                  ? Row(
                                children: [
                                  Text(
                                    "Z01 = ",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: size.width * 0.04,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.3,
                                    height: size.height * 0.04,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        enabledBorder:
                                        const OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.zero,
                                            borderSide: BorderSide(
                                                color: Colors
                                                    .transparent)),
                                        contentPadding:
                                        EdgeInsets.symmetric(
                                          horizontal: size.width * 0.02,
                                        ),
                                        fillColor:
                                        equivalentImpedanceValueEntered
                                            ? correctEquivalentImpedanceValueEntered
                                            ? kGreenColor
                                            : kRedColor
                                            : kGreyColor,
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
                                        hintText:
                                        equivalentImpedanceValueEntered
                                            ? "$equivalentImpedanceByUser"
                                            : '0.0',
                                        hintStyle: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: size.width * 0.04,
                                            color:
                                            equivalentImpedanceValueEntered
                                                ? kWhiteColor
                                                : kBlackColor),
                                      ),
                                      keyboardType:
                                      TextInputType.number,
                                      onChanged:
                                      _onEquivalentImpedanceChanged,
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: size.width * 0.04,
                                          color:
                                          equivalentImpedanceValueEntered
                                              ? kWhiteColor
                                              : kBlackColor),
                                      readOnly:
                                      equivalentImpedanceValueEntered,
                                    ),
                                  ),
                                ],
                              )
                                  : const Zero(),
                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              equivalentImpedanceValueEntered == true
                                  ? Text(
                                "The Correct Answer is: $equivalentImpedanceAnswer Ohms",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: size.width * 0.04,
                                    color: const Color(0xFF31B565)),
                              )
                                  : SizedBox(
                                width: size.width * 0.02,
                              ),
                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              addedToObservation == true
                                  ? const CommonDivider()
                                  : const Zero(),
                              addedToObservation == true
                                  ? Text(
                                "3. Calculate the Equivalent leakage reactance referred to HV side:",
                                style: TextStyle(
                                    letterSpacing: -0.6,
                                    fontFamily: "Poppins",
                                    fontSize: size.width * 0.035),
                              )
                                  : const Zero(),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              addedToObservation == true
                                  ? Text(
                                "Equivalent leakage reactance referred to HV side, X01 = √ (Z01  – R01  )",
                                style: TextStyle(
                                    letterSpacing: -0.6,
                                    fontFamily: "Poppins",
                                    fontSize: size.width * 0.035),
                              )
                                  : const Zero(),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              addedToObservation == true
                                  ? Row(
                                children: [
                                  Text(
                                    "X01 = ",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: size.width * 0.04,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.3,
                                    height: size.height * 0.04,
                                    child: TextField(
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        enabledBorder:
                                        const OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.zero,
                                            borderSide: BorderSide(
                                                color: Colors
                                                    .transparent)),
                                        contentPadding:
                                        EdgeInsets.symmetric(
                                          horizontal: size.width * 0.02,
                                        ),
                                        fillColor:
                                        equivalentLeakageReactanceValueEntered
                                            ? correctEquivalentLeakageReactanceValueEntered
                                            ? kGreenColor
                                            : kRedColor
                                            : kGreyColor,
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
                                        hintText:
                                        equivalentLeakageReactanceValueEntered
                                            ? "$equivalentLeakageReactanceByUser"
                                            : '0.0',
                                        hintStyle: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: size.width * 0.04,
                                            color:
                                            equivalentLeakageReactanceValueEntered
                                                ? kWhiteColor
                                                : kBlackColor),
                                      ),
                                      keyboardType:
                                      TextInputType.number,
                                      onChanged:
                                      _onEquivalentLeakageReactanceChanged,
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: size.width * 0.04,
                                          color:
                                          equivalentLeakageReactanceValueEntered
                                              ? kWhiteColor
                                              : kBlackColor),
                                      readOnly:
                                      equivalentLeakageReactanceValueEntered,
                                    ),
                                  ),
                                ],
                              )
                                  : const Zero(),
                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              equivalentLeakageReactanceValueEntered == true
                                  ? Text(
                                "The Correct Answer is: $equivalentLeakageReactanceAnswer Ohms",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: size.width * 0.04,
                                    color: const Color(0xFF31B565)),
                              )
                                  : SizedBox(
                                width: size.width * 0.02,
                              ),
                              addedToObservation == true
                                  ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.25,
                                    vertical: size.height * 0.025),
                                child: SizedBox(
                                  height: size.height * 0.05,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        equivalentResistanceByUser = 0.0;
                                        equivalentImpedanceByUser =
                                        0.0;
                                        equivalentLeakageReactanceByUser = 0.0;

                                        equivalentResistanceValueEntered =
                                        false;
                                        equivalentImpedanceValueEntered =
                                        false;
                                        equivalentLeakageReactanceValueEntered =
                                        false;


                                        correctEquivalentResistanceValueEntered =
                                        false;
                                        correctEquivalentImpedanceValueEntered =
                                        false;
                                        correctEquivalentLeakageReactanceValueEntered =
                                        false;


                                        equivalentResistanceAnswer = 0.0;
                                        equivalentImpedanceAnswer =
                                        0.0;
                                        equivalentLeakageReactanceAnswer = 0.0;

                                        vSco = 0;
                                        iSco = 0;
                                        wSco = 0;
                                        v2o = 0;

                                        addedToObservation = false;


                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                        kPrimaryLightColor,
                                        elevation: 0),
                                    child: const Text(
                                      "Reset",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Poppins",
                                          fontSize: 21),
                                    ),
                                  ),
                                ),
                              )
                                  : const Zero(),
                              addedToObservation == true
                                  ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.25),
                                child: SizedBox(
                                  height: size.height * 0.05,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        if (equivalentResistanceValueEntered ==
                                            false) {
                                          equivalentResistanceValueEntered =
                                          true;
                                          if (equivalentResistanceByUser <=
                                              equivalentResistanceAnswer +
                                                  0.1 &&
                                              equivalentResistanceByUser >=
                                                  equivalentResistanceAnswer -
                                                      0.1) {
                                            correctEquivalentResistanceValueEntered =
                                            true;
                                          }
                                        }
                                        if (equivalentImpedanceValueEntered ==
                                            false) {
                                          equivalentImpedanceValueEntered =
                                          true;
                                          if (equivalentImpedanceByUser <=
                                              equivalentImpedanceAnswer +
                                                  0.1 &&
                                              equivalentImpedanceByUser >=
                                                  equivalentImpedanceAnswer -
                                                      0.1) {
                                            correctEquivalentImpedanceValueEntered =
                                            true;
                                          }
                                        }
                                        if (equivalentLeakageReactanceValueEntered ==
                                            false) {
                                          equivalentLeakageReactanceValueEntered = true;
                                          if (equivalentLeakageReactanceByUser <=
                                              equivalentLeakageReactanceAnswer +
                                                  5 &&
                                              equivalentLeakageReactanceByUser >=
                                                  equivalentLeakageReactanceAnswer -
                                                      5) {
                                            correctEquivalentLeakageReactanceValueEntered =
                                            true;
                                          }
                                        }
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: kPrimaryColor,
                                        elevation: 0),
                                    child: const Text(
                                      "Submit",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins",
                                          fontSize: 21),
                                    ),
                                  ),
                                ),
                              )
                                  : const Zero(),
                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              SizedBox(
                                height: size.height * 0.015,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.25),
                                child: SizedBox(
                                  height: size.height * 0.05,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return QuizScreen(
                                              title: scTitle,
                                              optionOne: scOptionOne,
                                              optionTwo: scOptionTwo,
                                              optionThree: scOptionThree,
                                              optionFour: scOptionFour,
                                              questionsList: scQuestionsList,
                                              experimentScreen:
                                              scExperimentScreen,
                                              noOfQuestions: scNoOfQuestions,
                                              correctAnswers:
                                              scCorrectAnswers, quizTitle: scAim,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: kPrimaryColor,
                                        elevation: 0),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: size.height*0.02,),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.25),
                            child: SizedBox(
                              height: size.height * 0.05,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return QuizScreen(
                                          title: scTitle,
                                          optionOne: scOptionOne,
                                          optionTwo: scOptionTwo,
                                          optionThree: scOptionThree,
                                          optionFour: scOptionFour,
                                          questionsList: scQuestionsList,
                                          experimentScreen:
                                          scExperimentScreen,
                                          noOfQuestions: scNoOfQuestions,
                                          correctAnswers:
                                          scCorrectAnswers, quizTitle: scAim,
                                        );
                                      },
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: kPrimaryColor,
                                    elevation: 0),
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
                        ],
                      )
                  )
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