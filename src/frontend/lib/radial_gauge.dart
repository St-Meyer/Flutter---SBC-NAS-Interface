import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';

class RadialGaugeWidget extends StatelessWidget{

  final double value;

  const RadialGaugeWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {

    return AnimatedRadialGauge(
      duration: const Duration(seconds: 1),
      curve: Curves.elasticOut,
      radius: 100,
      value: value,
      axis: GaugeAxis(
        min: 0,
        max: 100,
        degrees: 180,
        style: const GaugeAxisStyle(
          thickness: 20,
          background: Color.fromARGB(255, 0, 0, 0),
          segmentSpacing: 4,
        ),
        pointer: GaugePointer.needle(
          width: 10, 
          height: 70, 
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        segments: [
          GaugeSegment(
            from: 0, 
            to: 33.3,
            color: Color.fromARGB(255, 0, 121, 36),
            cornerRadius: Radius.zero
          ),
          GaugeSegment(
            from: 33.3, 
            to: 66.6,
            color: Color.fromARGB(255, 159, 103, 0),
            cornerRadius: Radius.zero
          ),
          GaugeSegment(
            from: 66.6, 
            to: 100,
            color: Color.fromARGB(255, 132, 0, 0),
            cornerRadius: Radius.zero
          ),
        ]
      ),
    );
  }
}