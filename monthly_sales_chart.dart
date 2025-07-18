import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MonthlySalesChart extends StatelessWidget {
  const MonthlySalesChart({super.key});

  @override
  Widget build(BuildContext context) {
    final services = ['Tarpaulin', 'Business Cards', 'Stickers', 'Flyers', 'ID Cards'];
    final prevMonth = [35000.0, 30000.0, 17000.0, 12000.0, 15000.0];
    final currMonth = [42000.0, 43000.0, 20000.0, 15000.0, 17000.0];
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Monthly Sales by Service', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87)),
            const SizedBox(height: 16),
            SizedBox(
              height: 260,
              child: BarChart(
                BarChartData(
                  barGroups: List.generate(services.length, (i) {
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(toY: prevMonth[i], color: Colors.lightBlue, width: 16),
                        BarChartRodData(toY: currMonth[i], color: Colors.blue, width: 16),
                      ],
                      barsSpace: 4,
                    );
                  }),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value >= 0 && value < services.length) {
                            return Text(services[value.toInt()]);
                          }
                          return const SizedBox.shrink();
                        },
                        interval: 1,
                      ),
                    ),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                  groupsSpace: 24,
                  barTouchData: BarTouchData(enabled: false),
                  minY: 0,
                  maxY: 60000,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                _Legend(color: Colors.lightBlue, label: 'Previous Month'),
                SizedBox(width: 16),
                _Legend(color: Colors.blue, label: 'Current Month'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  const _Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 16, height: 8, color: color),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
} 