import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '../models/expense.dart';

class PieChartWidget extends StatelessWidget {
  final List<Expense> expenses;

  PieChartWidget({required this.expenses});

  @override
  Widget build(BuildContext context) {
    final dataMap = {
      for (var e in expenses) e.category: e.amount,
    };

    final colorList = expenses.map((e) => Color(int.parse('0xFF${e.colorHex.substring(1)}'))).toList();

    return PieChart(
      dataMap: dataMap,
      colorList: colorList,
      chartType: ChartType.disc,
      chartValuesOptions: ChartValuesOptions(showChartValuesInPercentage: true),
      legendOptions: LegendOptions(showLegends: true),
    );
  }
}
