import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

double radius = 80;

class PieChartContainer extends StatelessWidget {
  const PieChartContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: PieChart(
        PieChartData(
          borderData: FlBorderData(show: false),
          centerSpaceRadius: 0,
          sectionsSpace: 2,

          sections: _getSections(),
        ),
      ),
    );
  }
  List<PieChartSectionData> _getSections() {
    return [
      PieChartSectionData(
        value: 100,
        title: '40%',
        color: Colors.blueAccent,
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        value: 30,
        title: '30%',
        color: Colors.redAccent,
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        value: 15,
        title: '15%',
        color: Colors.greenAccent,
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        value: 15,
        title: '15%',
        color: Colors.orangeAccent,
        radius: 100,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }

}
