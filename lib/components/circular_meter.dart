import 'package:flutter/material.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CircularMeter extends StatefulWidget {
  const CircularMeter(
      {Key? key, required this.meterName, required this.value, required this.range1, required this.range2, required this.fontSize, required this.showLabels, required this.fontSizeM, required this.showFirstLabel, required this.firstColorCut, required this.secondColorCut,  required this.thirdColorCut})
      : super(key: key);
  final String meterName;
  final double value;
  final double range1;
  final double range2;
  final double fontSize;
  final double fontSizeM;
  final bool showLabels;
  final bool showFirstLabel;
  final double firstColorCut;
  final double secondColorCut;
  final double thirdColorCut;


  @override
  _CircularMeterState createState() => _CircularMeterState();
}

class _CircularMeterState extends State<CircularMeter> {
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
        animationDuration: 1000,
        enableLoadingAnimation: true,
        title: GaugeTitle(
            text: widget.meterName,
            textStyle: TextStyle(
                fontSize: widget.fontSizeM, fontWeight: FontWeight.bold)),
        axes: <RadialAxis>[
          RadialAxis(minimum: widget.range1,
              maximum: widget.range2,
              showLabels: widget.showLabels,
              labelsPosition: ElementsPosition.inside,
              labelOffset: 09,
              showFirstLabel: widget.showFirstLabel,
              ranges: <GaugeRange>[
                GaugeRange(
                    startValue: 0,
                    endValue:  widget.firstColorCut,
                    // sizeUnit: GaugeSizeUnit.logicalPixel,
                    // gradient: SweepGradient(
                    //   colors: [Colors.red,Colors.blue],stops:[0,2] ,
                    // ) ,
                    // rangeOffset: 1,
                    // label: "High",
                    // labelStyle: s,
                    color: kGreenColor,
                    startWidth: 5,
                    endWidth: 5),
                GaugeRange(
                    startValue: widget.firstColorCut,
                    endValue: widget.secondColorCut,
                    color: Colors.orange,
                    startWidth: 5,
                    endWidth: 5),
                GaugeRange(
                    startValue: widget.secondColorCut,
                    endValue: widget.thirdColorCut,
                    color: kRedColor,
                    startWidth: 5,
                    endWidth: 5)
              ],
              pointers: <GaugePointer>[
                NeedlePointer(
                  enableAnimation: true,
                  animationDuration: 1000,
                  value: widget.value,
                  needleStartWidth: 0.02,
                  needleEndWidth: 5,
                )
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Text('${widget.value}',
                        style: TextStyle(
                            fontSize: widget.fontSize,
                            fontWeight: FontWeight.bold)),
                    angle: 90,
                    positionFactor: 0.5)
              ])
        ]);
  }
}
