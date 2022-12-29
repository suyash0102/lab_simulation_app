import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lab_simulation_app/components/add_to_observation_btn.dart';
import 'package:lab_simulation_app/components/circular_meter.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/ui/labs/secondYear/EE/machine/fieldControl/fcData.dart';
import 'package:lab_simulation_app/ui/quiz_module/screens/start_screen.dart';
import 'package:lab_simulation_app/ui/viva_voice_module/screens/viva_voice_instructions_page.dart';
import 'package:segment_display/segment_display.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:toggle_switch/toggle_switch.dart';

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
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }

  bool machineOn = true;
  late SfCartesianChart chart;
  late TrackballBehavior _trackballBehavior;

  // SfSliderTheme _voltageSlider() {
  //   return SfSliderTheme(
  //       data: SfSliderThemeData(tooltipBackgroundColor: Colors.red),
  //       child: SfSlider.vertical(
  //         min: 1.0,
  //         max: 20.0,
  //         // onChanged: null,
  //         onChanged: switchOn
  //             ? (dynamic values) {
  //                 setState(() {
  //                   V = values;
  //                   V = roundDouble(V, 1);
  //                   I0 = (V / Zsc);
  //                   W = pow(I0, 2) * Rsc;
  //                 });
  //               }
  //             : null,
  //         value: switchOn ? V : 0,
  //         // enableTooltip: true,
  //         numberFormat: NumberFormat('#'),
  //       ));
  // }

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
                    shuntRes = values;
                    shuntRes = roundDouble(shuntRes, 1);

                    machineOn = true;
                    // if(values>2){
                    //   player.play(AssetSource(
                    //       'audio/machine_audio.mp3'));
                    // }
                  });
                }
              : null,
          value: switchOn ? shuntRes : 0,
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

  double speed = 0.0;
  double voltageSupply = 230.0;
  double shuntRes = 300.0;
  double fieldCurrent = 0.0;

  bool addedToObservation = false;
  bool generateGraph = false;

  int indexOneObservation = 0;
  int indexTwoObservation = 0;

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

  double equivalentResistanceByUser = 0.0;
  double equivalentImpedanceByUser = 0.0;
  double equivalentLeakageReactanceByUser = 0.0;

  double equivalentResistanceAnswer = 0.0;
  double equivalentImpedanceAnswer = 0.0;
  double equivalentLeakageReactanceAnswer = 0.0;

  int theoryIndex = 0;

  List<double> fieldOne = [0.0, 0.0, 0.0, 0.0, 0.0];
  List<double> fieldTwo = [0.0, 0.0, 0.0, 0.0, 0.0];

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(fieldOne[0], fieldTwo[0]),
      ChartData(fieldOne[1], fieldTwo[1]),
      ChartData(fieldOne[2], fieldTwo[2]),
      ChartData(fieldOne[3], fieldTwo[3]),
      ChartData(fieldOne[4], fieldTwo[4])
    ];
    chart = SfCartesianChart(
        backgroundColor: Colors.white,
        primaryXAxis: NumericAxis(interval: 10),
        title: ChartTitle(text: 'Speed Vs Field Current'),
        trackballBehavior: _trackballBehavior,
        // legend: Legend(isVisible: true),
        series: <CartesianSeries>[
          LineSeries<ChartData, double>(
              // isVisibleInLegend:true,
              // xAxisName: 'SSssssssssS',
              // yAxisName: 'sdssdsd',
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y),
        ]);
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
                            height: size.height * 0.085,
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
                                            fontSize: size.width * 0.045),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.04,
                                      ),
                                      Expanded(
                                        child: Text(
                                          fcAim,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              fontSize: size.width * 0.037,
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
                                      children: fcProcedure.map((strone) {
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
                                      fcCalculations,
                                      style: TextStyle(
                                          fontSize: size.width * 0.04,
                                          fontFamily: 'Poppins'),
                                    )
                                  ],
                                )
                              : Row(children: [
                                  Expanded(
                                    child: Text(
                                      fcTheory,
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
                                            switchOn
                                                ? fieldCurrent
                                                : fieldCurrent = 0;
                                            switchOn ? speed : speed = 0;
                                            switchOn
                                                ? voltageSupply
                                                : voltageSupply = 0;
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
                                              switchOn
                                                  ? voltageSupply
                                                  : voltageSupply = 0;
                                              switchOn ? speed : speed = 0;
                                              switchOn
                                                  ? fieldCurrent
                                                  : fieldCurrent = 0;
                                            });
                                          },
                                          child: switchOn
                                              ? AddToObservationBtn(
                                                  onPressed: () {
                                                    setState(() {
                                                      addedToObservation = true;
                                                      fieldOne.insert(
                                                          indexOneObservation++,
                                                          fieldCurrent);
                                                      fieldTwo.insert(
                                                          indexTwoObservation++,
                                                          speed);
                                                      print(fieldOne);
                                                      print(fieldTwo);
                                                      print(fieldOne
                                                          .elementAt(0));
                                                      print(fieldOne
                                                          .elementAt(1));
                                                      print(fieldOne
                                                          .elementAt(2));
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
                                    switchOn
                                        ? Padding(
                                            padding: EdgeInsets.only(
                                                top: size.height * 0.0012,
                                                left: size.width * 0.075,
                                                right: size.width * 0.027),
                                            child: SizedBox(
                                              height: size.height * 0.30,
                                              width: size.width * 0.85,
                                              child: Image.asset(
                                                  "assets/images/field_control1.jpg"),
                                            ),
                                          )
                                        : Padding(
                                            padding: EdgeInsets.only(
                                                left: size.width * 0.075,
                                                right: size.width * 0.027),
                                            child: SizedBox(
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
                                            ? Text("$shuntRes")
                                            : const Text("0.0")),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.065,
                                            left: size.width * 0.015),
                                        child: const Text("R=")),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.065,
                                            left: size.width * 0.9),
                                        child: switchOn
                                            ? Text("$voltageSupply")
                                            : const Text("0.0")),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            top: size.height * 0.065,
                                            left: size.width * 0.86),
                                        child: const Text("V=")),
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
                                                ? roundDouble(fieldCurrent, 1)
                                                : 0.0,
                                            range1: 0,
                                            range2: 1,
                                            firstColorCut: 0.33,
                                            secondColorCut: 0.66,
                                            thirdColorCut: 1,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: size.height * 0.139,
                                        left: size.width * 0.0185,
                                      ),
                                      child: SizedBox(
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
                                        curve: Curves.linear,
                                        turns: turns,
                                        duration: Duration(
                                            seconds:
                                                rotationSpeed == 0 ? 0 : 11),
                                        child: SizedBox(
                                          height: size.height * 0.032,
                                          width: size.width * 0.85,
                                          child: Image.asset(
                                              "assets/images/rotor_part_2.png"),
                                        ),
                                      ),
                                    ),
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
                                          child: CircularMeter(
                                            showFirstLabel: true,
                                            fontSizeM: 12,
                                            showLabels: false,
                                            fontSize: 0,
                                            meterName: "Speed",
                                            value: switchOn
                                                ? roundDouble(speed, 1)
                                                : 0.0,
                                            range1: 0,
                                            range2: 2000,
                                            firstColorCut: 666,
                                            secondColorCut: 1332,
                                            thirdColorCut: 2000,
                                          )),
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
                                                ? roundDouble(voltageSupply, 1)
                                                : 0.0,
                                            range1: 0,
                                            range2: 300,
                                            firstColorCut: 100,
                                            secondColorCut: 200,
                                            thirdColorCut: 300,
                                          )),
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
                                            onChanged: switchOn
                                                ? (dynamic values) {
                                                    setState(() {
                                                      rotationSpeed = 0;
                                                      rotationSpeed =
                                                          values / 2;
                                                      _changeRotation();
                                                      shuntRes = values;
                                                      shuntRes = roundDouble(
                                                          shuntRes, 3);
                                                      fieldCurrent = 230 /
                                                          (300 + shuntRes);
                                                      speed = -1037.9 *
                                                              fieldCurrent +
                                                          1899.2;
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
                                            value: switchOn ? shuntRes : 0,
                                            // enableTooltip: true,
                                            numberFormat: NumberFormat('#'),
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: size.width * 0.82,
                                        top: size.height * 0.061,
                                      ),
                                      child: SfSliderTheme(
                                          data: SfSliderThemeData(
                                              tooltipBackgroundColor:
                                                  Colors.red),
                                          child: SfSlider.vertical(
                                            min: 1.0,
                                            max: 230.0,
                                            // onChanged: null,
                                            onChanged: switchOn
                                                ? (dynamic values) {
                                                    setState(() {
                                                      if (values > 30) {
                                                        // while(values>30){
                                                        rotationSpeed =
                                                            values / 30;
                                                        // }
                                                      } else {
                                                        rotationSpeed = 0;
                                                      }
                                                      voltageSupply = values;
                                                      voltageSupply =
                                                          roundDouble(
                                                              voltageSupply, 3);
                                                      fieldCurrent = 230 /
                                                          (300 + shuntRes);
                                                      speed = -1037.9 *
                                                              fieldCurrent +
                                                          1899.2;
                                                    });
                                                  }
                                                : null,
                                            value: switchOn ? voltageSupply : 0,
                                            // enableTooltip: true,
                                            numberFormat: NumberFormat('#'),
                                          )),
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
                                          child: CircularMeter(
                                            showFirstLabel: true,
                                            showLabels: true,
                                            fontSizeM: size.width * 0.04,
                                            fontSize: size.width * 0.04,
                                            meterName: "Voltage Supply",
                                            value: switchOn
                                                ? roundDouble(voltageSupply, 1)
                                                : 0.0,
                                            range1: 0,
                                            range2: 300,
                                            firstColorCut: 100,
                                            secondColorCut: 200,
                                            thirdColorCut: 300,
                                          )),
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
                                            meterName: "Field Current",
                                            value: switchOn
                                                ? roundDouble(fieldCurrent, 1)
                                                : 0.0,
                                            range1: 0,
                                            range2: 1,
                                            firstColorCut: 0.33,
                                            secondColorCut: 0.66,
                                            thirdColorCut: 1,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.2,
                                          left: size.width * 0.55),
                                      child: Container(
                                          color: Colors.transparent,
                                          height: size.height * 0.165,
                                          width: size.width * 0.28,
                                          child: CircularMeter(
                                            showFirstLabel: false,
                                            fontSizeM: size.width * 0.04,
                                            showLabels: true,
                                            fontSize: size.width * 0.03,
                                            meterName: "Speed",
                                            value: switchOn
                                                ? roundDouble(speed, 1)
                                                : 0.0,
                                            range1: 0,
                                            range2: 2000,
                                            firstColorCut: 666,
                                            secondColorCut: 1332,
                                            thirdColorCut: 2000,
                                          )),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.11),
                                      child: SizedBox(
                                        height: size.height * 0.3,
                                        width: size.width * 0.85,
                                        child: Image.asset(
                                            "assets/images/tachometer.png"),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.385,
                                          top: size.height * 0.22),
                                      child: Container(
                                        height: size.height * 0.03,
                                        width: size.width * 0.088,
                                        decoration: const BoxDecoration(
                                            color: Color(0xFF555d50)),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.385,
                                          top: size.height * 0.23),
                                      child: SevenSegmentDisplay(
                                        segmentStyle: RectSegmentStyle(
                                            enabledColor: kBlackColor,
                                            disabledColor: Colors.grey[700]),
                                        size: 1,
                                        value: "${roundDouble(speed, 1)}",
                                        // characterCount: 3,
                                        characterSpacing: 1.0,
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                  ],
                                ),
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
                                //             showFirstLabel: true,
                                //             fontSizeM: size.width * 0.01,
                                //             showLabels: false,
                                //             fontSize: 0,
                                //             meterName: "W",
                                //             value: switchOn
                                //                 ? roundDouble(speed, 1)
                                //                 : 0.0,
                                //             range1: 0,
                                //             range2: 30,
                                //             firstColorCut: 100,
                                //             secondColorCut: 200,
                                //             thirdColorCut: 300,
                                //           )),
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
                                //             showFirstLabel: true,
                                //             fontSizeM: size.width * 0.015,
                                //             showLabels: false,
                                //             fontSize: 0,
                                //             meterName: "A",
                                //             value: switchOn
                                //                 ? roundDouble(voltageSupply, 1)
                                //                 : 0.0,
                                //             range1: 0,
                                //             range2: 10,
                                //             firstColorCut: 100,
                                //             secondColorCut: 200,
                                //             thirdColorCut: 300,
                                //           )),
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
                                //             showFirstLabel: true,
                                //             fontSizeM: size.width * 0.015,
                                //             showLabels: false,
                                //             fontSize: 0,
                                //             meterName: "Vsc",
                                //             value: switchOn
                                //                 ? roundDouble(voltageSupply, 1)
                                //                 : 0.0,
                                //             range1: 0,
                                //             range2: 25,
                                //             firstColorCut: 100,
                                //             secondColorCut: 200,
                                //             thirdColorCut: 300,
                                //           )),
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
                                //       child: _rheostatSlider(),
                                //     ),
                                //     Padding(
                                //         padding: EdgeInsets.only(
                                //             top: size.height * 0.052,
                                //             left: size.width * 0.063),
                                //         child: switchOn
                                //             ? Text("$voltageSupply")
                                //             : const Text("0.0")),
                                //     Padding(
                                //         padding: EdgeInsets.only(
                                //             top: size.height * 0.052,
                                //             left: size.width * 0.03),
                                //         child: const Text("V=")),
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
                                //                 switchOn
                                //                     ? voltageSupply = 230.0
                                //                     : null;
                                //                 switchOn ? voltageSupply : voltageSupply = 0;
                                //                 switchOn ? fieldCurrent : fieldCurrent = 0;
                                //                 switchOn ? speed : speed = 0;
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
                                //                 switchOn ? fieldCurrent : fieldCurrent = 0;
                                //                 switchOn ? voltageSupply : voltageSupply = 0;
                                //                 switchOn ? speed : speed = 0;
                                //               });
                                //             },
                                //             child: switchOn
                                //                 ? GestureDetector(
                                //                     onTap: () {
                                //                       setState(() {
                                //                         fieldTwo.add(fieldCurrent);
                                //                         fieldThree.add(speed);
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
                                //                 showFirstLabel: false,
                                //                 showLabels: true,
                                //                 fontSizeM: size.width * 0.02,
                                //                 fontSize: size.width * 0.017,
                                //                 meterName: "Vsc",
                                //                 value: switchOn
                                //                     ? roundDouble(
                                //                         voltageSupply, 1)
                                //                     : 0.0,
                                //                 range1: 0,
                                //                 range2: 300,
                                //                 firstColorCut: 100,
                                //                 secondColorCut: 200,
                                //                 thirdColorCut: 300,
                                //               )),
                                //         ),
                                //         Padding(
                                //           padding: EdgeInsets.only(
                                //               left: size.width * 0.15),
                                //           child: Container(
                                //               color: Colors.white,
                                //               height: size.height * 0.3,
                                //               width: size.width * 0.12,
                                //               child: CircularMeter(
                                //                 showFirstLabel: true,
                                //                 fontSizeM: size.width * 0.02,
                                //                 fontSize: size.width * 0.017,
                                //                 showLabels: true,
                                //                 meterName: "A",
                                //                 value: switchOn
                                //                     ? roundDouble(fieldCurrent, 1)
                                //                     : 0.0,
                                //                 range1: 0,
                                //                 range2: 10,
                                //                 firstColorCut: 100,
                                //                 secondColorCut: 200,
                                //                 thirdColorCut: 300,
                                //               )),
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
                                //                 showFirstLabel: false,
                                //                 showLabels: true,
                                //                 fontSizeM: size.width * 0.02,
                                //                 fontSize: size.width * 0.017,
                                //                 meterName: "W",
                                //                 value: switchOn
                                //                     ? roundDouble(fieldCurrent, 1)
                                //                     : 0.0,
                                //                 range1: 0,
                                //                 range2: 30,
                                //                 firstColorCut: 100,
                                //                 secondColorCut: 200,
                                //                 thirdColorCut: 300,
                                //               )),
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
                              FixedColumnWidth(size.width * 0.28),
                          border: TableBorder.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 2),
                          children: [
                            TableRow(children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: size.height * 0.01,
                                    bottom: size.height * 0.04),
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
                                    EdgeInsets.only(top: size.height * 0.01),
                                child: Tooltip(
                                  triggerMode: TooltipTriggerMode.tap,
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                      color: Colors.white,
                                      fontSize: size.width * 0.03),
                                  message: 'Field Current If (A)',
                                  child: Text('Field Current If (A)',
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
                                    EdgeInsets.only(top: size.height * 0.01),
                                child: Tooltip(
                                  triggerMode: TooltipTriggerMode.tap,
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                      color: Colors.white,
                                      fontSize: size.width * 0.03),
                                  message: 'Speed',
                                  child: Text('Speed \n(RPM)',
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
                                '1',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: size.width * 0.035),
                              ),
                              Text(
                                "${roundDouble(fieldOne[0], 2)} A",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: size.width * 0.035),
                              ),
                              Text(
                                "${roundDouble(fieldTwo[0], 0)} RPM",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: size.width * 0.035),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                '2',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: size.width * 0.035),
                              ),
                              Text(
                                "${roundDouble(fieldOne[1], 2)} A",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: size.width * 0.035),
                              ),
                              Text(
                                "${roundDouble(fieldTwo[1], 0)} RPM",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: size.width * 0.035),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                '3',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: size.width * 0.035),
                              ),
                              Text(
                                "${roundDouble(fieldOne[2], 2)} A",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: size.width * 0.035),
                              ),
                              Text(
                                "${roundDouble(fieldTwo[2], 0)} RPM",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: size.width * 0.035),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                '4',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: size.width * 0.035),
                              ),
                              Text(
                                "${roundDouble(fieldOne[3], 2)} A",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: size.width * 0.035),
                              ),
                              Text(
                                "${roundDouble(fieldTwo[3], 0)} RPM",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: size.width * 0.035),
                              ),
                            ]),
                            TableRow(children: [
                              Text(
                                '5',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: size.width * 0.035),
                              ),
                              Text(
                                "${roundDouble(fieldOne[4], 2)} A",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: size.width * 0.035),
                              ),
                              Text(
                                "${roundDouble(fieldTwo[4], 0)} RPM",
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
                              generateGraph == false
                                  ? Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.18,
                                          vertical: size.height * 0.025),
                                      child: SizedBox(
                                        height: size.height * 0.05,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              generateGraph = true;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: kPrimaryColor,
                                              elevation: 0),
                                          child: Text(
                                            "Generate Graph",
                                            style: TextStyle(
                                                color: kWhiteColor,
                                                fontFamily: "Poppins",
                                                fontSize: size.width * 0.05),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const Zero(),
                              generateGraph
                                  ? SizedBox(
                                      height: size.height * 0.4,
                                      width: size.width * 0.8,
                                      child: chart)
                                  : const Zero(),
                              // addedToObservation == true
                              //     ? Text(
                              //   "1. Calculate the value of Equivalent resistance referred to HV side:",
                              //   style: TextStyle(
                              //       fontFamily: "Poppins",
                              //       letterSpacing: -0.6,
                              //       fontSize: size.width * 0.035),
                              // )
                              //     : const Zero(),
                              // SizedBox(
                              //   height: size.height * 0.02,
                              // ),
                              // addedToObservation == true
                              //     ? Text(
                              //   "Equivalent resistance referred to HV side, R01 = Wsc/ Isc^2",
                              //   style: TextStyle(
                              //       fontFamily: "Poppins",
                              //       letterSpacing: -0.6,
                              //       fontSize: size.width * 0.035),
                              // )
                              //     : const Zero(),
                              // SizedBox(
                              //   height: size.height * 0.02,
                              // ),
                              // addedToObservation == true
                              //     ? Row(
                              //   children: [
                              //     Text(
                              //       "R01 = ",
                              //       style: TextStyle(
                              //         fontFamily: "Poppins",
                              //         fontSize: size.width * 0.04,
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: size.width * 0.02,
                              //     ),
                              //     SizedBox(
                              //       width: size.width * 0.3,
                              //       height: size.height * 0.04,
                              //       child: TextField(
                              //         autofocus: false,
                              //         textAlign: TextAlign.center,
                              //         decoration: InputDecoration(
                              //           enabledBorder:
                              //           const OutlineInputBorder(
                              //               borderRadius:
                              //               BorderRadius.zero,
                              //               borderSide: BorderSide(
                              //                   color: Colors
                              //                       .transparent)),
                              //           contentPadding:
                              //           EdgeInsets.symmetric(
                              //             horizontal: size.width * 0.02,
                              //           ),
                              //           fillColor:
                              //           equivalentResistanceValueEntered
                              //               ? correctEquivalentResistanceValueEntered
                              //               ? kGreenColor
                              //               : kRedColor
                              //               : kGreyColor,
                              //           border:
                              //           const OutlineInputBorder(
                              //               borderRadius:
                              //               BorderRadius.zero,
                              //               borderSide: BorderSide(
                              //                   color:
                              //                   Colors.white)),
                              //           focusedBorder:
                              //           const OutlineInputBorder(
                              //               borderRadius:
                              //               BorderRadius.zero,
                              //               borderSide: BorderSide(
                              //                   color: Colors
                              //                       .transparent)),
                              //           focusColor: Colors.black,
                              //           hintText:
                              //           equivalentResistanceValueEntered
                              //               ? "$equivalentResistanceByUser"
                              //               : '0.0',
                              //           hintStyle: TextStyle(
                              //               fontFamily: "Poppins",
                              //               fontSize: size.width * 0.04,
                              //               color:
                              //               equivalentResistanceValueEntered
                              //                   ? kWhiteColor
                              //                   : kBlackColor),
                              //         ),
                              //         keyboardType:
                              //         TextInputType.number,
                              //         onChanged:
                              //         _onEquivalentResistanceChanged,
                              //         style: TextStyle(
                              //             fontFamily: "Poppins",
                              //             fontSize: size.width * 0.04,
                              //             color:
                              //             equivalentResistanceValueEntered
                              //                 ? kWhiteColor
                              //                 : kBlackColor),
                              //         readOnly:
                              //         equivalentResistanceValueEntered,
                              //       ),
                              //     ),
                              //   ],
                              // )
                              //     : const Zero(),
                              // SizedBox(
                              //   height: size.height * 0.015,
                              // ),
                              // equivalentResistanceValueEntered == true
                              //     ? Text(
                              //   "The Correct Answer is: $equivalentResistanceAnswer Ohms",
                              //   style: TextStyle(
                              //       fontFamily: "Poppins",
                              //       fontSize: size.width * 0.04,
                              //       color: const Color(0xFF31B565)),
                              // )
                              //     : SizedBox(
                              //   width: size.width * 0.02,
                              // ),
                              // SizedBox(
                              //   height: size.height * 0.015,
                              // ),
                              // addedToObservation == true
                              //     ? const CommonDivider()
                              //     : const Zero(),
                              // addedToObservation == true
                              //     ? Text(
                              //   "2. Calculate the value of Equivalent impedance referred to HV side:",
                              //   style: TextStyle(
                              //       fontFamily: "Poppins",
                              //       letterSpacing: -0.6,
                              //       fontSize: size.width * 0.035),
                              // )
                              //     : const Zero(),
                              // SizedBox(
                              //   height: size.height * 0.02,
                              // ),
                              // addedToObservation == true
                              //     ? Text(
                              //   "Equivalent impedance referred to HV side, Z01 = Vsc / Isc",
                              //   style: TextStyle(
                              //       letterSpacing: -0.6,
                              //       fontFamily: "Poppins",
                              //       fontSize: size.width * 0.035),
                              // )
                              //     : const Zero(),
                              // SizedBox(
                              //   height: size.height * 0.02,
                              // ),
                              // addedToObservation == true
                              //     ? Row(
                              //   children: [
                              //     Text(
                              //       "Z01 = ",
                              //       style: TextStyle(
                              //         fontFamily: "Poppins",
                              //         fontSize: size.width * 0.04,
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: size.width * 0.02,
                              //     ),
                              //     SizedBox(
                              //       width: size.width * 0.3,
                              //       height: size.height * 0.04,
                              //       child: TextField(
                              //         textAlign: TextAlign.center,
                              //         decoration: InputDecoration(
                              //           enabledBorder:
                              //           const OutlineInputBorder(
                              //               borderRadius:
                              //               BorderRadius.zero,
                              //               borderSide: BorderSide(
                              //                   color: Colors
                              //                       .transparent)),
                              //           contentPadding:
                              //           EdgeInsets.symmetric(
                              //             horizontal: size.width * 0.02,
                              //           ),
                              //           fillColor:
                              //           equivalentImpedanceValueEntered
                              //               ? correctEquivalentImpedanceValueEntered
                              //               ? kGreenColor
                              //               : kRedColor
                              //               : kGreyColor,
                              //           border:
                              //           const OutlineInputBorder(
                              //               borderRadius:
                              //               BorderRadius.zero,
                              //               borderSide: BorderSide(
                              //                   color:
                              //                   Colors.white)),
                              //           focusedBorder:
                              //           const OutlineInputBorder(
                              //               borderRadius:
                              //               BorderRadius.zero,
                              //               borderSide: BorderSide(
                              //                   color: Colors
                              //                       .transparent)),
                              //           focusColor: Colors.black,
                              //           hintText:
                              //           equivalentImpedanceValueEntered
                              //               ? "$equivalentImpedanceByUser"
                              //               : '0.0',
                              //           hintStyle: TextStyle(
                              //               fontFamily: "Poppins",
                              //               fontSize: size.width * 0.04,
                              //               color:
                              //               equivalentImpedanceValueEntered
                              //                   ? kWhiteColor
                              //                   : kBlackColor),
                              //         ),
                              //         keyboardType:
                              //         TextInputType.number,
                              //         onChanged:
                              //         _onEquivalentImpedanceChanged,
                              //         style: TextStyle(
                              //             fontFamily: "Poppins",
                              //             fontSize: size.width * 0.04,
                              //             color:
                              //             equivalentImpedanceValueEntered
                              //                 ? kWhiteColor
                              //                 : kBlackColor),
                              //         readOnly:
                              //         equivalentImpedanceValueEntered,
                              //       ),
                              //     ),
                              //   ],
                              // )
                              //     : const Zero(),
                              // SizedBox(
                              //   height: size.height * 0.015,
                              // ),
                              // equivalentImpedanceValueEntered == true
                              //     ? Text(
                              //   "The Correct Answer is: $equivalentImpedanceAnswer Ohms",
                              //   style: TextStyle(
                              //       fontFamily: "Poppins",
                              //       fontSize: size.width * 0.04,
                              //       color: const Color(0xFF31B565)),
                              // )
                              //     : SizedBox(
                              //   width: size.width * 0.02,
                              // ),
                              // SizedBox(
                              //   height: size.height * 0.015,
                              // ),
                              // addedToObservation == true
                              //     ? const CommonDivider()
                              //     : const Zero(),
                              // addedToObservation == true
                              //     ? Text(
                              //   "3. Calculate the Equivalent leakage reactance referred to HV side:",
                              //   style: TextStyle(
                              //       letterSpacing: -0.6,
                              //       fontFamily: "Poppins",
                              //       fontSize: size.width * 0.035),
                              // )
                              //     : const Zero(),
                              // SizedBox(
                              //   height: size.height * 0.02,
                              // ),
                              // addedToObservation == true
                              //     ? Text(
                              //   "Equivalent leakage reactance referred to HV side, X01 = √ (Z01  – R01  )",
                              //   style: TextStyle(
                              //       letterSpacing: -0.6,
                              //       fontFamily: "Poppins",
                              //       fontSize: size.width * 0.035),
                              // )
                              //     : const Zero(),
                              // SizedBox(
                              //   height: size.height * 0.02,
                              // ),
                              // addedToObservation == true
                              //     ? Row(
                              //   children: [
                              //     Text(
                              //       "X01 = ",
                              //       style: TextStyle(
                              //         fontFamily: "Poppins",
                              //         fontSize: size.width * 0.04,
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: size.width * 0.02,
                              //     ),
                              //     SizedBox(
                              //       width: size.width * 0.3,
                              //       height: size.height * 0.04,
                              //       child: TextField(
                              //         textAlign: TextAlign.center,
                              //         decoration: InputDecoration(
                              //           enabledBorder:
                              //           const OutlineInputBorder(
                              //               borderRadius:
                              //               BorderRadius.zero,
                              //               borderSide: BorderSide(
                              //                   color: Colors
                              //                       .transparent)),
                              //           contentPadding:
                              //           EdgeInsets.symmetric(
                              //             horizontal: size.width * 0.02,
                              //           ),
                              //           fillColor:
                              //           equivalentLeakageReactanceValueEntered
                              //               ? correctEquivalentLeakageReactanceValueEntered
                              //               ? kGreenColor
                              //               : kRedColor
                              //               : kGreyColor,
                              //           border:
                              //           const OutlineInputBorder(
                              //               borderRadius:
                              //               BorderRadius.zero,
                              //               borderSide: BorderSide(
                              //                   color:
                              //                   Colors.white)),
                              //           focusedBorder:
                              //           const OutlineInputBorder(
                              //               borderRadius:
                              //               BorderRadius.zero,
                              //               borderSide: BorderSide(
                              //                   color: Colors
                              //                       .transparent)),
                              //           focusColor: Colors.black,
                              //           hintText:
                              //           equivalentLeakageReactanceValueEntered
                              //               ? "$equivalentLeakageReactanceByUser"
                              //               : '0.0',
                              //           hintStyle: TextStyle(
                              //               fontFamily: "Poppins",
                              //               fontSize: size.width * 0.04,
                              //               color:
                              //               equivalentLeakageReactanceValueEntered
                              //                   ? kWhiteColor
                              //                   : kBlackColor),
                              //         ),
                              //         keyboardType:
                              //         TextInputType.number,
                              //         onChanged:
                              //         _onEquivalentLeakageReactanceChanged,
                              //         style: TextStyle(
                              //             fontFamily: "Poppins",
                              //             fontSize: size.width * 0.04,
                              //             color:
                              //             equivalentLeakageReactanceValueEntered
                              //                 ? kWhiteColor
                              //                 : kBlackColor),
                              //         readOnly:
                              //         equivalentLeakageReactanceValueEntered,
                              //       ),
                              //     ),
                              //   ],
                              // )
                              //     : const Zero(),
                              // SizedBox(
                              //   height: size.height * 0.015,
                              // ),
                              // equivalentLeakageReactanceValueEntered == true
                              //     ? Text(
                              //   "The Correct Answer is: $equivalentLeakageReactanceAnswer Ohms",
                              //   style: TextStyle(
                              //       fontFamily: "Poppins",
                              //       fontSize: size.width * 0.04,
                              //       color: const Color(0xFF31B565)),
                              // )
                              //     : SizedBox(
                              //   width: size.width * 0.02,
                              // ),
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
                                              fieldOne = [
                                                0.0,
                                                0.0,
                                                0.0,
                                                0.0,
                                                0.0,
                                              ];
                                              fieldTwo = [
                                                0.0,
                                                0.0,
                                                0.0,
                                                0.0,
                                                0.0,
                                              ];
                                              addedToObservation = false;
                                              generateGraph = false;
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
                                                equivalentLeakageReactanceValueEntered =
                                                    true;
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
                                      title: fcTitle,
                                      optionOne: fcOptionOne,
                                      optionTwo: fcOptionTwo,
                                      optionThree: fcOptionThree,
                                      optionFour: fcOptionFour,
                                      questionsList: fcQuestionsList,
                                      experimentScreen:
                                      fcExperimentScreen,
                                      noOfQuestions: fcNoOfQuestions,
                                      correctAnswers:
                                      fcCorrectAnswers,
                                      quizTitle: fcAim,
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
                                    return VivaVoiceInstructionsScreen(
                                      title: fcTitle,
                                      quizTitle: fcAim,
                                    );
                                  },
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                elevation: 0),
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

  void show() {
    _trackballBehavior.showByIndex(1);
  }

  void hide() {
    _trackballBehavior.hide();
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

class ChartData {
  ChartData(this.x, this.y);

  final double x;
  final double y;
}
