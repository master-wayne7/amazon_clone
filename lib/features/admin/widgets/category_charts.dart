import 'package:amazno_clone/features/admin/model/sales_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CategoryCharts extends StatefulWidget {
  const CategoryCharts(
      {super.key, required this.sales, required this.totalEarnings});
  final List<Sales> sales;
  final int totalEarnings;

  @override
  State<CategoryCharts> createState() => _CategoryChartsState();
}

class _CategoryChartsState extends State<CategoryCharts> {
  bool isAnimating = false;
  @override
  void initState() {
    super.initState();
    animate();
  }

  void animate() async {
    await Future.delayed(const Duration(milliseconds: 1));
    isAnimating = true;
    setState(() {});
  }

  String formatLargeNumber(double value) {
    if (value.abs() >= 1e12) {
      return '${(value / 1e12).toStringAsFixed(1)}T'; // Trillions
    } else if (value.abs() >= 1e9) {
      return '${(value / 1e9).toStringAsFixed(1)}B'; // Billions
    } else if (value.abs() >= 1e6) {
      return '${(value / 1e6).toStringAsFixed(1)}M'; // Millions
    } else if (value.abs() >= 1e3) {
      return '${(value / 1e3).toStringAsFixed(1)}K'; // Thousands
    } else {
      return value.toString(); // Return the original value for smaller numbers
    }
  }

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData>? data = [
      BarChartGroupData(
        x: 0,
        barsSpace: 25,
        barRods: [
          BarChartRodData(
            toY: isAnimating ? widget.totalEarnings.toDouble() : 0,
            color: Colors.cyan,
            width: 16,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
      ...widget.sales
          .map(
            (e) => BarChartGroupData(
              x: widget.sales.indexOf(e) + 1,
              barsSpace: 25,
              barRods: [
                BarChartRodData(
                  toY: isAnimating ? e.earning.toDouble() : 0,
                  color: Colors.cyan,
                  width: 16,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          )
          .toList()
    ];
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: BarChart(
        BarChartData(
          maxY: widget.totalEarnings + (0.2 * widget.totalEarnings),
          // alignment: BarChartAlignment.center,
          barGroups: data,
          borderData: FlBorderData(
            show: false,
          ),
          gridData: const FlGridData(show: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              axisNameSize: 20,
              drawBelowEverything: false,
              axisNameWidget: const Text("Price"),
              sideTitles: SideTitles(
                reservedSize: 40,
                showTitles: true,
                getTitlesWidget: (value, meta) =>
                    SizedBox(child: Text(formatLargeNumber(value))),
              ),
            ),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              axisNameSize: 16,
              drawBelowEverything: false,
              axisNameWidget: const Text("Category"),
              sideTitles: SideTitles(
                reservedSize: 40,
                getTitlesWidget: (val, meta) => bottomTitles(val, meta),
                showTitles: true,
              ),
            ),
          ),
        ),
        swapAnimationCurve: Curves.decelerate,
        swapAnimationDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    List<String> titles = [
      "Total\nEarning",
      ...widget.sales.map((e) => e.label).toList()
    ];
    debugPrint(value.toString());

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 10,
      ),
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 1, //margin top
      child: text,
    );
  }
}
