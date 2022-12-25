import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lab_simulation_app/components/add_to_observation_btn.dart';
import 'package:lab_simulation_app/components/circular_meter.dart';
import 'package:lab_simulation_app/components/common_divider.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/ui/labs/secondYear/EE/machine/ocTest/ocData.dart';
import 'package:lab_simulation_app/ui/quiz_module/components/question_answer_divider.dart';
import 'package:lab_simulation_app/ui/quiz_module/screens/start_screen.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:toggle_switch/toggle_switch.dart';

class OCTestScreen extends StatefulWidget {
  const OCTestScreen({Key? key}) : super(key: key);

  @override
  _OCTestScreenState createState() => _OCTestScreenState();
}

class _OCTestScreenState extends State<OCTestScreen> {
  void _onMagnetizingComponentChanged(String value) {
    setState(() {
      magnetizingComponentByUser = double.parse(value);
    });
  }

  void _onNoLoadPowerFactorChanged(String value) {
    setState(() {
      noLoadPowerFactorByUser = double.parse(value);
    });
  }

  void _onCoreLossComponentChanged(String value) {
    setState(() {
      coreLossComponentByUser = double.parse(value);
    });
  }

  void _onMagnetizingBranchReactanceChanged(String value) {
    setState(() {
      magnetizingBranchReactanceByUser = double.parse(value);
    });
  }

  void _onResistanceChanged(String value) {
    setState(() {
      resistanceByUser = double.parse(value);
    });
  }

  SizedBox zero() {
    return const SizedBox(
      height: 0,
    );
  }

  SfSliderTheme _activeSlider() {
    return SfSliderTheme(
        data: SfSliderThemeData(tooltipBackgroundColor: Colors.red),
        child: SfSlider.vertical(
          min: 1.0,
          max: 120.0,
          // onChanged: null,
          onChanged: switchOn
              ? (dynamic values) {
                  setState(() {
                    V1 = values;
                    V1 = roundDouble(V1, 1);
                    Im = V1 / X0;
                    Iw = V1 / R0;
                    I0 = sqrt(pow(Im, 2) + pow(Iw, 2));
                    Phi = acos(Iw / I0) * (180.0 / pi);
                    W = V1 * I0 * (cos(Phi * pi / 180));
                    V2 = 2 * V1;
                  });
                }
              : null,
          value: switchOn ? V1 : 0,
          // enableTooltip: true,
          numberFormat: NumberFormat('#'),
        ));
  }

  bool correctNoLoadPowerFactorValueEntered = false;
  bool correctMagnetizingComponentValueEntered = false;
  bool correctCoreLossComponentValueEntered = false;
  bool correctResistanceValueEntered = false;
  bool correctMagnetizingBranchReactanceValueEntered = false;

  bool noLoadPowerFactorValueEntered = false;
  bool magnetizingComponentValueEntered = false;
  bool coreLossComponentValueEntered = false;
  bool resistanceValueEntered = false;
  bool magnetizingBranchReactanceValueEntered = false;

  bool addedToObservation = false;

  double noLoadPowerFactorByUser = 0.0;
  double magnetizingComponentByUser = 0.0;
  double coreLossComponentByUser = 0.0;
  double resistanceByUser = 0.0;
  double magnetizingBranchReactanceByUser = 0.0;

  double noLoadPowerFactorAnswer = 0.0;
  double magnetizingComponentAnswer = 0.0;
  double coreLossComponentAnswer = 0.0;
  double resistanceAnswer = 0.0;
  double magnetizingBranchReactanceAnswer = 0.0;

  bool switchOn = false;
  double V1 = 0.0;
  double Im = 0.0;
  double R0 = 696.125;
  double X0 = 166.90;
  double Iw = 0.0;
  double Phi = 0.0;
  double I0 = 0.0;
  double W = 0.0;
  double V2 = 0.0;

  double v1o = 0.0;
  double i0o = 0.0;
  double wo = 0.0;
  double v2o = 0.0;
  double phio = 0.0;

  int theoryIndex = 0;

  List<String> getTab() {
    return ["Aim", "Procedure", "Theory"];
  }

  List<String> str = [
    "Set the input voltage at 230V and 50Hz frequency to the autotransformer input.\n"
        "",
    "Switch on the supply, keeping output voltage at auto-transformer at zero (by setting turns ratio of autotransfomer at zero).\n"
        "",
    "Increase the voltage in set up (by increasing the turns ratio of the auto-transformer)upto rated primary voltage(i.e approximate 110 V) and observe the no load current, input power and the primary and secondary voltages corresponding to each value of the applied voltage.\n"
        "",
    "Now click on 'simulate' to get the value of the shunt parameters (Ro and Xm) of the transformer.\n"
        "",
    "Click on 'fill the Table' tab to tabulate the primary voltage(V1),no load current or primary current(I0), input power(Pi) and secondary voltage(V2)corresponding to each value of the applied voltage in Observation table.\n"
        "",
    "Then change the input voltage to take another observation.\n" ""
  ];
  List<double> fieldOne = [];
  List<double> fieldTwo = [];
  List<double> fieldThree = [];
  List<double> fieldFour = [];
  var isSelected1 = [false, false, true];
  var isSelected2 = [false, false, true];
  var isSelected3 = [false, false, true];
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return SafeArea(
        child: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                  iconTheme: const IconThemeData(color: Colors.white),
                  backgroundColor: kPrimaryColor,
                  centerTitle: true,
                  title: Text(
                    ocTitle,
                    style:
                        TextStyle(fontFamily: 'Poppins', color: Colors.white),
                  ),
                  bottom: TabBar(
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.lightBlueAccent, Colors.purpleAccent],
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      indicatorColor: Colors.black,
                      tabs: <Widget>[
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
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
                          ToggleSwitch(
                            customTextStyles: [
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
                              print('switched to: $index');
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
                                          ocAim,
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
                                      children: str.map((strone) {
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
                                      ocCalculations,
                                      style: TextStyle(
                                          fontSize: size.width * 0.04,
                                          fontFamily: 'Poppins'),
                                    )
                                  ],
                                )
                              : Row(children: [
                                  Expanded(
                                    child: Text(
                                      ocTheory,
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
                                            switchOn ? V1 = 115 : null;
                                            switchOn ? I0 : I0 = 0;
                                            switchOn ? W : W = 0;
                                            switchOn ? V2 : V2 = 0;
                                            Im = V1 / X0;
                                            Iw = V1 / R0;
                                            I0 = sqrt(pow(Im, 2) + pow(Iw, 2));
                                            Phi = acos(Iw / I0) * (180.0 / pi);
                                            W = V1 * I0 * (cos(Phi * pi / 180));
                                            V2 = 2 * V1;
                                            // Toggle light when tapped.
                                          });
                                        },
                                        child: switchOn
                                            ? Container(
                                                height: size.height * 0.055,
                                                child: Image.asset(
                                                    "assets/images/s1.png"))
                                            : Container(
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
                                              switchOn ? V1 = 115 : null;
                                              switchOn ? I0 : I0 = 0;
                                              switchOn ? W : W = 0;
                                              switchOn ? V2 : V2 = 0;
                                              // Toggle light when tapped.
                                            });
                                          },
                                          child: switchOn
                                              ? AddToObservationBtn(
                                                  onPressed: () {
                                                    setState(() {
                                                      addedToObservation = true;
                                                      v1o = V1;
                                                      i0o = I0;
                                                      wo = W;
                                                      v2o = V2;
                                                      noLoadPowerFactorAnswer =
                                                          roundDouble(
                                                              roundDouble(
                                                                      wo, 2) /
                                                                  (v1o *
                                                                      roundDouble(
                                                                          i0o,
                                                                          2)),
                                                              3);
                                                      phio = acos(
                                                          noLoadPowerFactorAnswer);
                                                      magnetizingComponentAnswer =
                                                          roundDouble(
                                                              roundDouble(
                                                                      i0o, 2) *
                                                                  sin(phio),
                                                              3);
                                                      coreLossComponentAnswer =
                                                          roundDouble(
                                                              roundDouble(
                                                                      i0o, 2) *
                                                                  cos(phio),
                                                              3);
                                                      resistanceAnswer =
                                                          roundDouble(
                                                              v1o /
                                                                  coreLossComponentAnswer,
                                                              3);
                                                      magnetizingBranchReactanceAnswer =
                                                          roundDouble(
                                                              v1o /
                                                                  magnetizingComponentAnswer,
                                                              3);
                                                      print(
                                                          ' $V1 $I0 $W $noLoadPowerFactorAnswer');
                                                      print(
                                                          ' $phio $magnetizingComponentAnswer');
                                                      print(
                                                          ' $phio $coreLossComponentAnswer');
                                                      print(
                                                          ' $phio $resistanceAnswer');
                                                      print(
                                                          ' $phio $magnetizingBranchReactanceAnswer');
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
                                            left: size.width * 0.085),
                                        child: switchOn
                                            ? Text("$V1")
                                            : Text("0.0")),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.065,
                                            left: size.width * 0.025),
                                        child: Text("V1=")),
                                    switchOn
                                        ? Padding(
                                            padding: EdgeInsets.only(
                                                top: size.height * 0.067,
                                                right: size.width * 0.025),
                                            child: Container(
                                              height: size.height * 0.207,
                                              child: Image.asset(
                                                  "assets/images/open_circuit_1.png"),
                                            ),
                                          )
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                top: size.height * 0.067,
                                                right: size.width * 0.027),
                                            child: Container(
                                              height: size.height * 0.207,
                                              child: Image.asset(
                                                  "assets/images/open_circuit_0.png"),
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
                                                  ? roundDouble(I0, 1)
                                                  : 0.0,
                                              range1: 0,
                                              range2: 10)),
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
                                              range2: 300)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.16,
                                          right: size.width * 0.02,
                                          left: size.width * 0.91),
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
                                              meterName: "V2",
                                              value: switchOn
                                                  ? roundDouble(V2, 1)
                                                  : 0.0,
                                              range1: 0,
                                              range2: 300)),
                                    ),
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
                                              meterName: "V1",
                                              value: switchOn
                                                  ? roundDouble(V1, 1)
                                                  : 0.0,
                                              range1: 0,
                                              range2: 115)),
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
                                              meterName: "V1",
                                              value: switchOn
                                                  ? roundDouble(V1, 1)
                                                  : 0.0,
                                              range1: 0,
                                              range2: 115)),
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
                                                  ? roundDouble(I0, 1)
                                                  : 0.0,
                                              range1: 0,
                                              range2: 10)),
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
                                              fontSizeM: size.width * 0.04,
                                              showLabels: true,
                                              fontSize: size.width * 0.04,
                                              meterName: "W",
                                              value: switchOn
                                                  ? roundDouble(W, 1)
                                                  : 0.0,
                                              range1: 0,
                                              range2: 300)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.45),
                                      child: Container(
                                          color: Colors.white,
                                          height: size.height * 0.195,
                                          width: size.width * 0.4,
                                          child: CircularMeter(
                                              showFirstLabel: true,
                                              fontSizeM: size.width * 0.04,
                                              showLabels: true,
                                              fontSize: size.width * 0.04,
                                              meterName: "V2",
                                              value: switchOn
                                                  ? roundDouble(V2, 1)
                                                  : 0.0,
                                              range1: 0,
                                              range2: 300)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Text("Transformer Rating: 500kVA 115/230",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                    )),
                              ],
                            )
                          : Row(
                              children: [
                                Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.455),
                                      child: Container(
                                          color: Colors.white,
                                          height: size.height * 0.11,
                                          width: size.width * 0.039,
                                          // width: 50,
                                          child: CircularMeter(
                                              showFirstLabel: true,
                                              fontSizeM: size.width * 0.01,
                                              showLabels: false,
                                              fontSize: 0,
                                              meterName: "W",
                                              value: switchOn
                                                  ? roundDouble(W, 1)
                                                  : 0.0,
                                              range1: 0,
                                              range2: 300)),
                                    ),
                                    switchOn
                                        ? Padding(
                                            padding: EdgeInsets.only(
                                              top: size.height * 0.06,
                                            ),
                                            child: Container(
                                              height: size.height * 0.65,
                                              width: size.width * 0.72,
                                              child: Image.asset(
                                                  "assets/images/open_circuit_1.png"),
                                            ),
                                          )
                                        : Padding(
                                            padding: EdgeInsets.only(
                                              top: size.height * 0.06,
                                            ),
                                            child: Container(
                                              height: size.height * 0.65,
                                              width: size.width * 0.72,
                                              child: Image.asset(
                                                  "assets/images/open_circuit_0.png"),
                                            ),
                                          ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.02,
                                          left: size.width * 0.32),
                                      child: Container(
                                          color: Colors.white,
                                          height: size.height * 0.15,
                                          width: size.width * 0.05,
                                          child: CircularMeter(
                                              showFirstLabel: true,
                                              fontSizeM: size.width * 0.015,
                                              showLabels: false,
                                              fontSize: 0,
                                              meterName: "A",
                                              value: switchOn
                                                  ? roundDouble(I0, 1)
                                                  : 0.0,
                                              range1: 0,
                                              range2: 10)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.37,
                                          left: size.width * 0.53),
                                      child: Container(
                                          color: Colors.white,
                                          height: size.height * 0.15,
                                          width: size.width * 0.05,
                                          child: CircularMeter(
                                              showFirstLabel: true,
                                              fontSizeM: size.width * 0.015,
                                              showLabels: false,
                                              fontSize: 0,
                                              meterName: "V1",
                                              value: switchOn
                                                  ? roundDouble(V1, 1)
                                                  : 0.0,
                                              range1: 0,
                                              range2: 115)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.37,
                                          left: size.width * 0.672),
                                      child: Container(
                                          color: Colors.white,
                                          height: size.height * 0.15,
                                          width: size.width * 0.05,
                                          child: CircularMeter(
                                              showFirstLabel: true,
                                              fontSizeM: size.width * 0.015,
                                              showLabels: false,
                                              fontSize: 0,
                                              meterName: "V2",
                                              value: switchOn
                                                  ? roundDouble(V2, 1)
                                                  : 0.0,
                                              range1: 0,
                                              range2: 300)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: size.width * 0.02,
                                        top: size.height * 0.15,
                                      ),
                                      child: _activeSlider(),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.052,
                                            left: size.width * 0.063),
                                        child: switchOn
                                            ? Text("$V1")
                                            : Text("0.0")),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.052,
                                            left: size.width * 0.03),
                                        child: Text("V1=")),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: size.height * 0.02),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                switchOn = !switchOn;
                                                switchOn ? V1 = 115.0 : null;
                                                switchOn ? I0 : I0 = 0;
                                                switchOn ? W : W = 0;
                                                switchOn ? V2 : V2 = 0;
                                                Im = V1 / X0;
                                                Iw = V1 / R0;
                                                I0 = sqrt(
                                                    pow(Im, 2) + pow(Iw, 2));
                                                Phi = acos(Iw / I0) *
                                                    (180.0 / pi);
                                                W = V1 *
                                                    I0 *
                                                    (cos(Phi * pi / 180));
                                                V2 = 2 * V1;
                                                // Toggle light when tapped.
                                              });
                                            },
                                            child: switchOn
                                                ? Container(
                                                    height: size.height * 0.09,
                                                    child: Image.asset(
                                                        "assets/images/s1.png"))
                                                : Padding(
                                                    padding: EdgeInsets.only(
                                                        right:
                                                            size.width * 0.14),
                                                    child: Container(
                                                        height:
                                                            size.height * 0.09,
                                                        child: Image.asset(
                                                            "assets/images/s0.png")),
                                                  ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.015,
                                              top: size.height * 0.02),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                switchOn ? V1 : V1 = 0;
                                                switchOn ? I0 : I0 = 0;
                                                switchOn ? W : W = 0;
                                                switchOn ? V2 : V2 = 0;
                                                // Toggle light when tapped.
                                              });
                                            },
                                            child: switchOn
                                                ? AddToObservationBtnH(
                                                    onPressed: () {
                                                      setState(() {
                                                        fieldOne.add(V1);
                                                        fieldTwo.add(I0);
                                                        fieldThree.add(W);
                                                        fieldFour.add(V2);
                                                      });
                                                    },
                                                  )
                                                : Container(
                                                    height: size.height * 0.020,
                                                  ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              right: size.width * 0.04),
                                          child: Container(
                                              color: Colors.white,
                                              height: size.height * 0.3,
                                              width: size.width * 0.12,
                                              child: CircularMeter(
                                                  showFirstLabel: false,
                                                  showLabels: true,
                                                  fontSizeM: size.width * 0.02,
                                                  fontSize: size.width * 0.017,
                                                  meterName: "V1",
                                                  value: switchOn
                                                      ? roundDouble(V1, 1)
                                                      : 0.0,
                                                  range1: 0,
                                                  range2: 115)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.15),
                                          child: Container(
                                              color: Colors.white,
                                              height: size.height * 0.3,
                                              width: size.width * 0.12,
                                              child: CircularMeter(
                                                  showFirstLabel: true,
                                                  fontSizeM: size.width * 0.02,
                                                  fontSize: size.width * 0.017,
                                                  showLabels: true,
                                                  meterName: "A",
                                                  value: switchOn
                                                      ? roundDouble(I0, 1)
                                                      : 0.0,
                                                  range1: 0,
                                                  range2: 10)),
                                        ),
                                      ],
                                    ),
                                    Stack(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.02,
                                              right: size.width * 0.04),
                                          child: Container(
                                              color: Colors.white,
                                              height: size.height * 0.3,
                                              width: size.width * 0.12,
                                              child: CircularMeter(
                                                  showFirstLabel: false,
                                                  showLabels: true,
                                                  fontSizeM: size.width * 0.02,
                                                  fontSize: size.width * 0.017,
                                                  meterName: "W",
                                                  value: switchOn
                                                      ? roundDouble(W, 1)
                                                      : 0.0,
                                                  range1: 0,
                                                  range2: 300)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: size.width * 0.15),
                                          child: Container(
                                              color: Colors.white,
                                              height: size.height * 0.3,
                                              width: size.width * 0.12,
                                              child: CircularMeter(
                                                  showFirstLabel: true,
                                                  fontSizeM: size.width * 0.02,
                                                  fontSize: size.width * 0.017,
                                                  showLabels: true,
                                                  meterName: "V2",
                                                  value: switchOn
                                                      ? roundDouble(V2, 1)
                                                      : 0.0,
                                                  range1: 0,
                                                  range2: 300)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
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
                                    child: Text('V1',
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
                                    child: Text('Io',
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
                                    child: Text('Wo',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Poppins",
                                            color: kPrimaryColor,
                                            fontSize: size.width * 0.04)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: size.height * 0.015,
                                      bottom: size.height * 0.015),
                                  child: Tooltip(
                                    triggerMode: TooltipTriggerMode.tap,
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins",
                                        color: Colors.white,
                                        fontSize: size.width * 0.03),
                                    message: 'Secondary Voltage V2 (H.V.Side)',
                                    child: Text('V2',
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
                                v1o == 0.0
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
                                        "\n$v1o V",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Poppins",
                                            color: Colors.black,
                                            fontSize: size.width * 0.035),
                                      ),
                                i0o == 0.0
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
                                        "\n${roundDouble(i0o, 2)} A",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Poppins",
                                            color: Colors.black,
                                            fontSize: size.width * 0.035),
                                      ),
                                wo == 0.0
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
                                        "\n${roundDouble(wo, 2)} W",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Poppins",
                                            color: Colors.black,
                                            fontSize: size.width * 0.035),
                                      ),
                                v2o == 0.0
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
                                        "\n$v2o V",
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
                                        "1. Calculate the value of No Load Power Factor:",
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
                                        "The no load power factor, Cos Φo = Wo/V1 x Io",
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
                                            "Cos Φo =",
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
                                                    noLoadPowerFactorValueEntered
                                                        ? correctNoLoadPowerFactorValueEntered
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
                                                    noLoadPowerFactorValueEntered
                                                        ? "$noLoadPowerFactorByUser"
                                                        : '0.0',
                                                hintStyle: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: size.width * 0.04,
                                                    color:
                                                        noLoadPowerFactorValueEntered
                                                            ? kWhiteColor
                                                            : kBlackColor),
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged:
                                                  _onNoLoadPowerFactorChanged,
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: size.width * 0.04,
                                                  color:
                                                      noLoadPowerFactorValueEntered
                                                          ? kWhiteColor
                                                          : kBlackColor),
                                              readOnly:
                                                  noLoadPowerFactorValueEntered,
                                            ),
                                          ),
                                        ],
                                      )
                                    : const Zero(),
                                SizedBox(
                                  height: size.height * 0.015,
                                ),
                                noLoadPowerFactorValueEntered == true
                                    ? Text(
                                        "The Correct Answer is: $noLoadPowerFactorAnswer",
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
                                        "2. Calculate the Magnetizing component of no load current:",
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
                                        "Magnetizing component of no load current, Im = Io    sin Φo",
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
                                            "Im =        ",
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
                                                    magnetizingComponentValueEntered
                                                        ? correctMagnetizingComponentValueEntered
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
                                                    magnetizingComponentValueEntered
                                                        ? "$magnetizingComponentByUser"
                                                        : '0.0',
                                                hintStyle: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: size.width * 0.04,
                                                    color:
                                                        magnetizingComponentValueEntered
                                                            ? kWhiteColor
                                                            : kBlackColor),
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged:
                                                  _onMagnetizingComponentChanged,
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: size.width * 0.04,
                                                  color:
                                                      magnetizingComponentValueEntered
                                                          ? kWhiteColor
                                                          : kBlackColor),
                                              readOnly:
                                                  magnetizingComponentValueEntered,
                                            ),
                                          ),
                                        ],
                                      )
                                    : const Zero(),
                                SizedBox(
                                  height: size.height * 0.015,
                                ),
                                magnetizingComponentValueEntered == true
                                    ? Text(
                                        "The Correct Answer is: $magnetizingComponentAnswer Ampere",
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
                                        "3. Calculate the Core loss component of no load current:",
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
                                        "Core loss component of no load current, Ic = Io cos Φo",
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
                                            "Ic =         ",
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
                                                    coreLossComponentValueEntered
                                                        ? correctCoreLossComponentValueEntered
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
                                                    coreLossComponentValueEntered
                                                        ? "$coreLossComponentByUser"
                                                        : '0.0',
                                                hintStyle: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: size.width * 0.04,
                                                    color:
                                                        coreLossComponentValueEntered
                                                            ? kWhiteColor
                                                            : kBlackColor),
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged:
                                                  _onCoreLossComponentChanged,
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: size.width * 0.04,
                                                  color:
                                                      coreLossComponentValueEntered
                                                          ? kWhiteColor
                                                          : kBlackColor),
                                              readOnly:
                                                  coreLossComponentValueEntered,
                                            ),
                                          ),
                                        ],
                                      )
                                    : const Zero(),
                                SizedBox(
                                  height: size.height * 0.015,
                                ),
                                coreLossComponentValueEntered == true
                                    ? Text(
                                        "The Correct Answer is: $coreLossComponentAnswer Ampere",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: size.width * 0.04,
                                            color: const Color(0xFF31B565)),
                                      )
                                    : SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                addedToObservation == true
                                    ? const CommonDivider()
                                    : const Zero(),
                                addedToObservation == true
                                    ? Text(
                                        "4. Calculate the Resistance representing core loss:",
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
                                        "Resistance representing core loss, Ro = V1 / Ic",
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
                                            "Ro =        ",
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
                                                fillColor: resistanceValueEntered
                                                    ? correctResistanceValueEntered
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
                                                hintText: resistanceValueEntered
                                                    ? "$resistanceByUser"
                                                    : '0.0',
                                                hintStyle: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: size.width * 0.04,
                                                    color:
                                                        resistanceValueEntered
                                                            ? kWhiteColor
                                                            : kBlackColor),
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: _onResistanceChanged,
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: size.width * 0.04,
                                                  color: resistanceValueEntered
                                                      ? kWhiteColor
                                                      : kBlackColor),
                                              readOnly: resistanceValueEntered,
                                            ),
                                          ),
                                        ],
                                      )
                                    : const Zero(),
                                SizedBox(
                                  height: size.height * 0.015,
                                ),
                                resistanceValueEntered == true
                                    ? Text(
                                        "The Correct Answer is: $resistanceAnswer Ohms",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: size.width * 0.04,
                                            color: const Color(0xFF31B565)),
                                      )
                                    : SizedBox(
                                        width: size.width * 0.02,
                                      ),
                                addedToObservation == true
                                    ? const CommonDivider()
                                    : const Zero(),
                                addedToObservation == true
                                    ? Text(
                                        "5. Calculate the Magnetizing branch reactance:",
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
                                        "Magnetizing branch reactance, Xo= V1 / Im",
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
                                            "Xo =        ",
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
                                                    magnetizingBranchReactanceValueEntered
                                                        ? correctMagnetizingBranchReactanceValueEntered
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
                                                    magnetizingBranchReactanceValueEntered
                                                        ? "$magnetizingBranchReactanceByUser"
                                                        : '0.0',
                                                hintStyle: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: size.width * 0.04,
                                                    color:
                                                        magnetizingBranchReactanceValueEntered
                                                            ? kWhiteColor
                                                            : kBlackColor),
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged:
                                                  _onMagnetizingBranchReactanceChanged,
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: size.width * 0.04,
                                                  color:
                                                      magnetizingBranchReactanceValueEntered
                                                          ? kWhiteColor
                                                          : kBlackColor),
                                              readOnly:
                                                  magnetizingBranchReactanceValueEntered,
                                            ),
                                          ),
                                        ],
                                      )
                                    : const Zero(),
                                SizedBox(
                                  height: size.height * 0.015,
                                ),
                                magnetizingBranchReactanceValueEntered == true
                                    ? Text(
                                        "The Correct Answer is: $magnetizingBranchReactanceAnswer Ohms",
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
                                                noLoadPowerFactorByUser = 0.0;
                                                magnetizingComponentByUser =
                                                    0.0;
                                                coreLossComponentByUser = 0.0;
                                                resistanceByUser = 0.0;
                                                magnetizingBranchReactanceByUser =
                                                    0.0;
                                                print(noLoadPowerFactorByUser);
                                                noLoadPowerFactorValueEntered =
                                                    false;
                                                magnetizingComponentValueEntered =
                                                    false;
                                                coreLossComponentValueEntered =
                                                    false;
                                                resistanceValueEntered = false;
                                                magnetizingBranchReactanceValueEntered =
                                                    false;
                                                correctMagnetizingComponentValueEntered =
                                                    false;
                                                correctResistanceValueEntered =
                                                    false;
                                                correctNoLoadPowerFactorValueEntered =
                                                    false;
                                                correctMagnetizingBranchReactanceValueEntered =
                                                    false;
                                                correctCoreLossComponentValueEntered =
                                                    false;

                                                noLoadPowerFactorAnswer = 0.0;
                                                magnetizingComponentAnswer =
                                                    0.0;
                                                coreLossComponentAnswer = 0.0;
                                                resistanceAnswer = 0.0;
                                                magnetizingBranchReactanceAnswer =
                                                    0.0;
                                                v1o = 0;
                                                i0o = 0;
                                                wo = 0;
                                                v2o = 0;

                                                addedToObservation = false;

                                                fieldOne.clear();
                                                fieldTwo.clear();
                                                fieldThree.clear();
                                                fieldFour.clear();
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
                                                if (noLoadPowerFactorValueEntered ==
                                                    false) {
                                                  noLoadPowerFactorValueEntered =
                                                      true;
                                                  if (noLoadPowerFactorByUser <=
                                                          noLoadPowerFactorAnswer +
                                                              0.1 &&
                                                      noLoadPowerFactorByUser >=
                                                          noLoadPowerFactorAnswer -
                                                              0.1) {
                                                    correctNoLoadPowerFactorValueEntered =
                                                        true;
                                                  }
                                                }
                                                if (magnetizingComponentValueEntered ==
                                                    false) {
                                                  magnetizingComponentValueEntered =
                                                      true;
                                                  if (magnetizingComponentByUser <=
                                                          magnetizingComponentAnswer +
                                                              0.1 &&
                                                      magnetizingComponentByUser >=
                                                          magnetizingComponentAnswer -
                                                              0.1) {
                                                    correctMagnetizingComponentValueEntered =
                                                        true;
                                                  }
                                                }
                                                if (coreLossComponentValueEntered ==
                                                    false) {
                                                  coreLossComponentValueEntered =
                                                      true;
                                                  if (coreLossComponentByUser <=
                                                          coreLossComponentAnswer +
                                                              0.1 &&
                                                      coreLossComponentByUser >=
                                                          coreLossComponentAnswer -
                                                              0.1) {
                                                    correctCoreLossComponentValueEntered =
                                                        true;
                                                  }
                                                }
                                                if (resistanceValueEntered ==
                                                    false) {
                                                  resistanceValueEntered = true;
                                                  if (resistanceByUser <=
                                                          resistanceAnswer +
                                                              5 &&
                                                      resistanceByUser >=
                                                          resistanceAnswer -
                                                              5) {
                                                    correctResistanceValueEntered =
                                                        true;
                                                  }
                                                }
                                                if (magnetizingBranchReactanceValueEntered ==
                                                    false) {
                                                  magnetizingBranchReactanceValueEntered =
                                                      true;
                                                  if (magnetizingBranchReactanceByUser <=
                                                          magnetizingBranchReactanceAnswer +
                                                              4 &&
                                                      magnetizingBranchReactanceByUser >=
                                                          magnetizingBranchReactanceAnswer -
                                                              4) {
                                                    correctMagnetizingBranchReactanceValueEntered =
                                                        true;
                                                  }
                                                }
                                                print(
                                                    magnetizingComponentValueEntered);
                                                print(
                                                    magnetizingComponentByUser);
                                                print(
                                                    correctMagnetizingComponentValueEntered);
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
                                // SizedBox(
                                //   height: size.height * 0.015,
                                // ),
                                // Padding(
                                //   padding: EdgeInsets.symmetric(
                                //       horizontal: size.width * 0.25),
                                //   child: SizedBox(
                                //     height: size.height * 0.05,
                                //     child: ElevatedButton(
                                //       onPressed: () {
                                //         // if (coreLossReactanceByUser <= 170.00 &&
                                //         //     coreLossReactanceByUser >= 162.0) {
                                //         //   clReactance = true;
                                //         // }
                                //         // if (coreLossResistanceByUser <=
                                //         //         700.00 &&
                                //         //     coreLossResistanceByUser >=
                                //         //         690.00) {
                                //         //   clResistance = true;
                                //         // }
                                //         // if (phiByUser <= 77.50 &&
                                //         //     phiByUser >= 75.50) {
                                //         //   clPhi = true;
                                //         // }
                                //         // setState(() {});
                                //       },
                                //       style: ElevatedButton.styleFrom(
                                //           backgroundColor: kPrimaryLightColor,
                                //           elevation: 0),
                                //       child: const Text(
                                //         "Retry",
                                //         style: TextStyle(
                                //             color: Colors.black,
                                //             fontFamily: "Poppins",
                                //             fontSize: 21),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // phiByUser == 0.0 ||
                                //         coreLossResistanceByUser == 0.0 ||
                                //         coreLossReactanceByUser == 0.0
                                //     ? const Text("")
                                //     : Column(
                                //         children: [
                                //           Text("$phiByUser"),
                                //           Text("$coreLossResistanceByUser"),
                                //           Text("$coreLossReactanceByUser"),
                                //         ],
                                //       ),
                                SizedBox(
                                  height: size.height * 0.015,
                                ),
                                // ElevatedButton(
                                //   onPressed: () {
                                //     setState(() {
                                //       fieldOne.clear();
                                //       fieldTwo.clear();
                                //       fieldThree.clear();
                                //       fieldFour.clear();
                                //     });
                                //   },
                                //   style: ElevatedButton.styleFrom(
                                //       backgroundColor: kPrimaryColor,
                                //       elevation: 0),
                                //   child: Text(
                                //     "Reset".toUpperCase(),
                                //     style: const TextStyle(
                                //         color: Colors.white,
                                //         fontFamily: "Poppins",
                                //         fontSize: 21),
                                //   ),
                                // ),
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
                                                title: ocTitle,
                                                optionOne: ocOptionOne,
                                                optionTwo: ocOptionTwo,
                                                optionThree: ocOptionThree,
                                                optionFour: ocOptionFour,
                                                questionsList: ocQuestionsList,
                                                experimentScreen:
                                                    ocExperimentScreen,
                                                noOfQuestions: ocNoOfQuestions,
                                                correctAnswers:
                                                    ocCorrectAnswers,
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
