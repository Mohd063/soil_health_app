import 'package:flutter/material.dart';
import 'package:soil_health_app/models/reading.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class ChartWidget extends StatelessWidget {
  final List<Reading> readings;

  const ChartWidget({super.key, required this.readings});

  @override
  Widget build(BuildContext context) {
    if (readings.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 260,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0, //  Clean borderless chart
        backgroundColor: Colors.white,
        title: ChartTitle(
          text: '🌱 Soil Temperature & Moisture Trend',
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.green,
          ),
        ),
        legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          overflowMode: LegendItemOverflowMode.wrap,
          textStyle: const TextStyle(fontSize: 12),
        ),
        primaryXAxis: DateTimeAxis(
          title: AxisTitle(
            text: 'Time',
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          dateFormat: DateFormat.Hm(), // HH:mm format
          majorGridLines: const MajorGridLines(width: 0.3),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
        ),
        primaryYAxis: NumericAxis(
          title: AxisTitle(
            text: 'Values',
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          labelStyle: const TextStyle(fontSize: 12),
          majorGridLines: const MajorGridLines(dashArray: [5, 5]), // dashed grid
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          header: '',
          canShowMarker: true,
         // borderRadius: 8,
          color: Colors.black87,
          textStyle: const TextStyle(color: Colors.white, fontSize: 12),
        ),
        series: <CartesianSeries>[
          // Moisture Line
          LineSeries<Reading, DateTime>(
            dataSource: readings,
            xValueMapper: (Reading reading, _) => reading.timestamp,
            yValueMapper: (Reading reading, _) => reading.moisture,
            name: 'Moisture (%)',
            color: Colors.blue,
            width: 2.5,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.circle,
              borderWidth: 2,
            ),
            enableTooltip: true,
          ),
          // Temperature Line
          LineSeries<Reading, DateTime>(
            dataSource: readings,
            xValueMapper: (Reading reading, _) => reading.timestamp,
            yValueMapper: (Reading reading, _) => reading.temperature,
            name: 'Temperature (°C)',
            color: Colors.red,
            width: 2.5,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.diamond,
              borderWidth: 2,
            ),
            enableTooltip: true,
          ),
        ],
      ),
    );
  }
}
