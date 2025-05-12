import 'package:flutter/material.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../generated/assets.dart';


class HoursOutGauge extends StatelessWidget {
  const HoursOutGauge({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:220,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 20,
            startAngle: 270,
            canRotateLabels:true,
            labelOffset:-13,
            endAngle: 270,
            showLabels: true,
            showTicks: true,
            axisLabelStyle: const GaugeTextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
            majorTickStyle: const MajorTickStyle(
              length: 3,
              thickness: 3,
            ),
            minorTickStyle: const MinorTickStyle(
              length: 5,
              thickness: 1,
            ),
            minorTicksPerInterval: 0,
            // Customizing the axis line
            axisLineStyle: const AxisLineStyle(
              thickness: 16,
              color: kBorderColor,
              dashArray: <double>[2, 2],
              cornerStyle: CornerStyle.bothCurve,
            ),
            // Adding the pointer
            pointers: <GaugePointer>[
              // Arc pointer for the blue segment
              RangePointer(
                pointerOffset:25,
                value: 3, // Value to indicate range from 0 to this value
                width: 10,
                color: kPrimaryColor,
                enableAnimation: true,
                animationDuration: 1000,
                animationType: AnimationType.easeInCirc,
                cornerStyle: CornerStyle.bothFlat,
              ),
              // Marker pointer for the triangle at the top
              MarkerPointer(
                value: 0,
                markerHeight: 8,
                markerWidth: 12,
                markerType: MarkerType.invertedTriangle,
                color:  kPrimaryColor,
                markerOffset: -20,
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Text(
                      '03:01:55',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Hours out',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                angle: 90,
                positionFactor: 0.1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}