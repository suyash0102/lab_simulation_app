import 'dart:io';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lab_simulation_app/components/circular_meter.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart' show NumberFormat;

const file = 'audio/machine_audio.mp3';

class FieldControlScreen extends StatefulWidget {
  const FieldControlScreen({Key? key}) : super(key: key);

  @override
  _FieldControlScreenState createState() => _FieldControlScreenState();
}

final player = AudioPlayer();

class _FieldControlScreenState extends State<FieldControlScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    const file = 'audio/machine_audio.mp3';
    super.initState();
  }

  bool machineOn = true;

  SfSliderTheme _voltageSlider() {
    return SfSliderTheme(
        data: SfSliderThemeData(tooltipBackgroundColor: Colors.red),
        child: SfSlider.vertical(
          min: 1.0,
          max: 20.0,
          // onChanged: null,
          onChanged: switchOn
              ? (dynamic values) {
                  setState(() {
                    V = values;
                    V = roundDouble(V, 1);
                    I0 = (V / Zsc);
                    W = pow(I0, 2) * Rsc;
                  });
                }
              : null,
          value: switchOn ? V : 0,
          // enableTooltip: true,
          numberFormat: NumberFormat('#'),
        ));
  }

  SfSliderTheme _rheostatSlider() {
    return SfSliderTheme(
        data: SfSliderThemeData(tooltipBackgroundColor: Colors.red),
        child: SfSlider.vertical(
          min: 0.1,
          max: 500.0,
          // onChanged: null,
          onChanged: switchOn
              ? (dynamic values) {
                  setState(() {
                    rotationSpeed = 0;
                    rotationSpeed = values / 2;
                    _changeRotation();
                    R = values;
                    R = roundDouble(R, 1);
                    I0 = (Vsc / Zsc);
                    W = pow(I0, 2) * Rsc;
                    machineOn = true;
                    // if(values>2){
                    //   player.play(AssetSource(
                    //       'audio/machine_audio.mp3'));
                    // }
                  });
                }
              : null,
          value: switchOn ? R : 0,
          // enableTooltip: true,
          numberFormat: NumberFormat('#'),
        ));
  }

  double rotationSpeed = 1.0;
  double turns = 0.0;

  void _changeRotation() {
    setState(() => turns += rotationSpeed);
  }

  bool switchOn = false;
  double R = 0.0;
  double Vsc = 0.0;
  double V1 = 0.0;
  double V = 0.0;
  double Rsc = 4.41;
  double Zsc = 4.6;
  double Im = 0.0;
  double R0 = 623.711;
  double X0 = 96.688;
  double Iw = 0.0;
  double voltageSupply = 230.0;
  double shuntRes = 300.0;
  double fieldCurrent = 0.0;
  double speed = 0.0;
  double Phi = 0.0;
  double I0 = 0.0;
  double W = 0.0;
  double V2 = 0.0;
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
                  title: const Text(
                    'Field Control Method',
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
                              width: 10,
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
                                            switchOn ? V1 = 20 : null;
                                            switchOn ? I0 : I0 = 0;
                                            switchOn ? W : W = 0;
                                            switchOn ? V2 : V2 = 0;
                                            I0 = (Vsc / Zsc);
                                            W = pow(I0, 2) * Rsc;
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
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.30),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            switchOn ? V1 = 230 : null;
                                            switchOn ? I0 : I0 = 0;
                                            switchOn ? W : W = 0;
                                            switchOn ? V2 : V2 = 0;
                                            // Toggle light when tapped.
                                          });
                                        },
                                        child: switchOn
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    fieldOne.add(V1);
                                                    fieldTwo.add(I0);
                                                    fieldThree.add(W);
                                                    fieldFour.add(V2);
                                                  });
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      border: Border.all(
                                                        width: 2,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    height: size.height * 0.04,
                                                    width: size.width * 0.4,
                                                    child: Center(
                                                        child: Text(
                                                            "Add to Observation Table"))),
                                              )
                                            : Container(
                                                height: size.height * 0.030,
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    switchOn
                                        ? Padding(
                                            padding: EdgeInsets.only(
                                                top: size.height * 0.0012,
                                                left: size.width * 0.075,
                                                right: size.width * 0.027),
                                            child: Container(
                                              height: size.height * 0.30,
                                              width: size.width * 0.85,
                                              child: Image.asset(
                                                  "assets/images/field_control1.jpg"),
                                            ),
                                          )
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                // top: size.height * 0.065,
                                                left: size.width * 0.075,
                                                right: size.width * 0.027),
                                            child: Container(
                                              height: size.height * 0.30,
                                              width: size.width * 0.85,
                                              child: Image.asset(
                                                  "assets/images/field_control0.jpg"),
                                            ),
                                          ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.065,
                                            left: size.width * 0.05),
                                        child: switchOn
                                            ? Text("$R")
                                            : const Text("0.0")),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.065,
                                            left: size.width * 0.015),
                                        child: Text("R=")),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.065,
                                            left: size.width * 0.9),
                                        child: switchOn
                                            ? Text("$Vsc")
                                            : Text("0.0")),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.065,
                                            left: size.width * 0.86),
                                        child: Text("V=")),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.058,
                                          left: size.width * 0.113),
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
                                        top: size.height * 0.139,
                                        left: size.width * 0.0185,
                                      ),
                                      child: Container(
                                        height: size.height * 0.060,
                                        width: size.width * 0.85,
                                        child: Image.asset(
                                            "assets/images/rotor_part_1.png"),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: size.height * 0.153,
                                        left: size.width * 0.0185,
                                      ),
                                      child: AnimatedRotation(
                                        // filterQuality: ,
                                        curve: Curves.linear,
                                        turns: turns,
                                        duration: Duration(
                                            seconds:
                                                rotationSpeed == 0 ? 0 : 11),
                                        child: Container(
                                          height: size.height * 0.032,
                                          width: size.width * 0.85,
                                          child: Image.asset(
                                              "assets/images/rotor_part_2.png"),
                                        ),
                                      ),
                                    ),
                                    // Transform.rotate(
                                    //   angle: rotationSpeed * 1000,
                                    //   child: Container(
                                    //     height: size.height * 0.032,
                                    //     width: size.width * 0.85,
                                    //     child: Image.asset(
                                    //         "assets/images/rotor_part_2.png"),
                                    //   ),
                                    // ),
                                    // DigitalLcdNumber(
                                    //   number: 9,
                                    //   color: Colors.red,
                                    // ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.11,
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
                                              meterName: "Speed",
                                              value: switchOn
                                                  ? roundDouble(W, 1)
                                                  : 0.0,
                                              range1: 0,
                                              range2: 30)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.13,
                                          left: size.width * 0.656),
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
                                              meterName: "V",
                                              value: switchOn
                                                  ? roundDouble(Vsc, 1)
                                                  : 0.0,
                                              range1: 0,
                                              range2: 25)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: size.width * 0.87,
                                        top: size.height * 0.061,
                                      ),
                                      child: SfSliderTheme(
                                          data: SfSliderThemeData(
                                              tooltipBackgroundColor:
                                                  Colors.red),
                                          child: SfSlider.vertical(
                                            min: 0.1,
                                            max: 500.0,
                                            // onChanged: null,
                                            onChanged: switchOn
                                                ? (dynamic values) {
                                                    setState(() {
                                                      rotationSpeed = 0;
                                                      rotationSpeed =
                                                          values / 2;
                                                      _changeRotation();
                                                      R = values;
                                                      R = roundDouble(R, 1);
                                                      I0 = (Vsc / Zsc);
                                                      W = pow(I0, 2) * Rsc;
                                                      machineOn = true;
                                                      if (values > 2) {
                                                        player.play(AssetSource(
                                                            'audio/machine_audio.mp3'));
                                                      }
                                                      if (values < 2) {
                                                        player.stop();
                                                      }
                                                    });
                                                  }
                                                : null,
                                            value: switchOn ? R : 0,
                                            // enableTooltip: true,
                                            numberFormat: NumberFormat('#'),
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: size.width * 0.82,
                                        top: size.height * 0.061,
                                      ),
                                      child: _voltageSlider(),
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
                                              meterName: "V",
                                              value: switchOn
                                                  ? roundDouble(Vsc, 1)
                                                  : 0.0,
                                              range1: 0,
                                              range2: 30)),
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
                                              meterName: "Speed",
                                              value: switchOn
                                                  ? roundDouble(W, 1)
                                                  : 0.0,
                                              range1: 0,
                                              range2: 30)),
                                    ),
                                  ],
                                ),
                                // Stack(
                                //   children: [
                                //     Container(
                                //       height: size.height * 0.3,
                                //       width: size.width * 0.85,
                                //       child: Image.asset(
                                //           "assets/images/tachometer.jpg"),
                                //     ),
                                //     Padding(
                                //       padding: EdgeInsets.only(
                                //           left: size.width * 0.385,
                                //           top: size.height * 0.11),
                                //       child: SevenSegmentDisplay(
                                //         segmentStyle: HexSegmentStyle(),
                                //         size: 2,
                                //         value: "$R",
                                //         // characterCount: 3,
                                //         characterSpacing: 1.0,
                                //         backgroundColor: Colors.cyan[900],
                                //       ),
                                //     ),
                                //   ],
                                // ),
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
                                              range2: 30)),
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
                                                  "assets/images/short_circuit_1.png"),
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
                                                  "assets/images/short_circuit_0.png"),
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
                                              meterName: "Vsc",
                                              value: switchOn
                                                  ? roundDouble(Vsc, 1)
                                                  : 0.0,
                                              range1: 0,
                                              range2: 25)),
                                    ),
                                    // Padding(
                                    //   padding: EdgeInsets.only(
                                    //       top: size.height * 0.37,
                                    //       left: size.width * 0.672),
                                    //   child: Container(
                                    //       color: Colors.white,
                                    //       height: size.height * 0.15,
                                    //       width: size.width * 0.05,
                                    //       child: CircularMeter(
                                    //           showFirstLabel: true,
                                    //           fontSizeM: size.width * 0.015,
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
                                        left: size.width * 0.02,
                                        top: size.height * 0.15,
                                      ),
                                      child: _rheostatSlider(),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.052,
                                            left: size.width * 0.063),
                                        child: switchOn
                                            ? Text("$Vsc")
                                            : Text("0.0")),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.052,
                                            left: size.width * 0.03),
                                        child: Text("V=")),
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
                                                switchOn ? Vsc = 230.0 : null;
                                                switchOn ? I0 : I0 = 0;
                                                switchOn ? W : W = 0;
                                                switchOn ? V2 : V2 = 0;

                                                I0 = (Vsc / Zsc);
                                                W = pow(I0, 2) * Rsc;
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
                                              left: size.width * 0.035,
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
                                                ? GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        fieldOne.add(V1);
                                                        fieldTwo.add(I0);
                                                        fieldThree.add(W);
                                                        fieldFour.add(V2);
                                                      });
                                                    },
                                                    child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.grey,
                                                          border: Border.all(
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                        height:
                                                            size.height * 0.09,
                                                        width:
                                                            size.width * 0.14,
                                                        child: Center(
                                                            child: Text(
                                                          "Add to Observation Table",
                                                          textAlign:
                                                              TextAlign.center,
                                                        ))),
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
                                                  meterName: "Vsc",
                                                  value: switchOn
                                                      ? roundDouble(Vsc, 1)
                                                      : 0.0,
                                                  range1: 0,
                                                  range2: 30)),
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
                                                  range2: 30)),
                                        ),
                                        // Padding(
                                        //   padding: EdgeInsets.only(
                                        //       left: size.width * 0.15),
                                        //   child: Container(
                                        //       color: Colors.white,
                                        //       height: size.height * 0.3,
                                        //       width: size.width * 0.12,
                                        //       child: CircularMeter(
                                        //           showFirstLabel: true,
                                        //           fontSizeM: size.width * 0.02,
                                        //           fontSize: size.width * 0.017,
                                        //           showLabels: true,
                                        //           meterName: "V2",
                                        //           value: switchOn
                                        //               ? roundDouble(V2, 1)
                                        //               : 0.0,
                                        //           range1: 0,
                                        //           range2: 300)),
                                        // ),
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
                          Table(
                            defaultColumnWidth:
                                FixedColumnWidth(size.width * 0.19),
                            border: TableBorder.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 2),
                            children: [
                              TableRow(children: [
                                Column(children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: size.height * 0.015),
                                    child: Text('Serial no. of Observation',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: size.width * 0.023)),
                                  )
                                ]),
                                Column(children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: size.height * 0.015),
                                    child: Text(
                                        'Primary Voltage V1 (L.V. Side)	',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: size.width * 0.023)),
                                  )
                                ]),
                                Column(children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: size.height * 0.015),
                                    child: Text(
                                        'Primary Current I0 (L.V. Side) (Amp)',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: size.width * 0.023)),
                                  )
                                ]),
                                Column(children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: size.height * 0.015),
                                    child: Text(
                                        'Input Power Pi (L.V. Side) (Watt)	',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: size.width * 0.023)),
                                  )
                                ]),
                                Column(children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: size.height * 0.0075),
                                    child: Text(
                                        'Secondary Volatge V2 (H.V.Side)\n',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: size.width * 0.023)),
                                  )
                                ]),
                              ]),
                              TableRow(children: [
                                Column(children: [Text('1st')]),
                                Column(children: [
                                  fieldOne.isEmpty
                                      ? Text("0.0")
                                      : Text("${fieldOne[0]}")
                                ]),
                                Column(children: [
                                  fieldTwo.isEmpty
                                      ? Text("0.0")
                                      : Text("${roundDouble(fieldTwo[0], 2)}")
                                ]),
                                Column(children: [
                                  fieldThree.isEmpty
                                      ? Text("0.0")
                                      : Text("${roundDouble(fieldThree[0], 2)}")
                                ]),
                                Column(children: [
                                  fieldFour.isEmpty
                                      ? Text("0.0")
                                      : Text("${fieldFour[0]}")
                                ]),
                              ]),
                              TableRow(children: [
                                Column(children: [Text('2nd')]),
                                Column(children: [
                                  fieldOne.length <= 1
                                      ? Text("")
                                      : Text("${fieldOne[1]}")
                                ]),
                                Column(children: [
                                  fieldTwo.length <= 1
                                      ? Text("")
                                      : Text("${roundDouble(fieldTwo[1], 2)}")
                                ]),
                                Column(children: [
                                  fieldThree.length <= 1
                                      ? Text("")
                                      : Text("${roundDouble(fieldThree[1], 2)}")
                                ]),
                                Column(children: [
                                  fieldFour.length <= 1
                                      ? Text("")
                                      : Text("${fieldFour[1]}")
                                ]),
                              ]),
                              TableRow(children: [
                                Column(children: [Text('3rd')]),
                                Column(children: [
                                  fieldOne.length <= 2
                                      ? Text("")
                                      : Text("${fieldOne[2]}")
                                ]),
                                Column(children: [
                                  fieldTwo.length <= 2
                                      ? Text("")
                                      : Text("${roundDouble(fieldTwo[2], 2)}")
                                ]),
                                Column(children: [
                                  fieldThree.length <= 2
                                      ? Text("")
                                      : Text("${roundDouble(fieldThree[2], 2)}")
                                ]),
                                Column(children: [
                                  fieldFour.length <= 2
                                      ? Text("")
                                      : Text("${fieldFour[2]}")
                                ]),
                              ]),
                              TableRow(children: [
                                Column(children: [Text('4th')]),
                                Column(children: [
                                  fieldOne.length <= 3
                                      ? Text("")
                                      : Text("${fieldOne[3]}")
                                ]),
                                Column(children: [
                                  fieldTwo.length <= 3
                                      ? Text("")
                                      : Text("${roundDouble(fieldTwo[3], 2)}")
                                ]),
                                Column(children: [
                                  fieldThree.length <= 3
                                      ? Text("")
                                      : Text("${roundDouble(fieldThree[3], 2)}")
                                ]),
                                Column(children: [
                                  fieldFour.length <= 3
                                      ? Text("")
                                      : Text("${fieldFour[3]}")
                                ]),
                              ]),
                              TableRow(children: [
                                Column(children: [Text('5th')]),
                                Column(children: [
                                  fieldOne.length <= 4
                                      ? Text("")
                                      : Text("${fieldOne[4]}")
                                ]),
                                Column(children: [
                                  fieldTwo.length <= 4
                                      ? Text("")
                                      : Text("${roundDouble(fieldTwo[4], 2)}")
                                ]),
                                Column(children: [
                                  fieldThree.length <= 4
                                      ? Text("")
                                      : Text("${roundDouble(fieldThree[4], 2)}")
                                ]),
                                Column(children: [
                                  fieldFour.length <= 4
                                      ? Text("")
                                      : Text("${fieldFour[4]}")
                                ]),
                              ]),
                            ],
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
