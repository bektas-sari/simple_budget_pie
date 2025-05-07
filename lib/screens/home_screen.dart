import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '../models/expense.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> expenses = [
    Expense(category: 'Food', amount: 1500, color: Colors.orangeAccent),
    Expense(category: 'Transport', amount: 800, color: Colors.lightGreen),
    Expense(category: 'Entertainment', amount: 600, color: Colors.purpleAccent),
  ];

  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  double get totalExpense =>
      expenses.fold(0.0, (sum, e) => sum + e.amount);

  void _addExpense() {
    final category = _categoryController.text.trim();
    final amount = double.tryParse(_amountController.text.trim());
    if (category.isNotEmpty && amount != null) {
      setState(() {
        expenses.add(
          Expense(
            category: category,
            amount: amount,
            color: Colors.primaries[expenses.length % Colors.primaries.length],
          ),
        );
      });
      _categoryController.clear();
      _amountController.clear();
    }
  }

  Map<String, double> get dataMap =>
      {for (var e in expenses) e.category: e.amount};
  List<Color> get colorList => expenses.map((e) => e.color).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.pie_chart_outline),
        title: const Text('Simple Budget Pie'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  const Text('Total Expense', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(
                    '\$${totalExpense.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    dataMap: dataMap,
                    colorList: colorList,
                    chartType: ChartType.disc,
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValuesInPercentage: true,
                      showChartValues: true,
                    ),
                    legendOptions: const LegendOptions(
                      showLegends: true,
                      legendPosition: LegendPosition.bottom,
                      legendTextStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount (\$)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addExpense,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Add Expense', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
