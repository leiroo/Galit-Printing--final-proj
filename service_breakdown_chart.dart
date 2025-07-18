import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ServiceBreakdownChart extends StatelessWidget {
  const ServiceBreakdownChart({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      {'label': 'Tarpaulin', 'value': 35.0, 'color': Colors.blue},
      {'label': 'Business Cards', 'value': 25.0, 'color': Colors.lightBlue},
      {'label': 'Stickers', 'value': 20.0, 'color': Colors.amber},
      {'label': 'Flyers', 'value': 15.0, 'color': Colors.pinkAccent},
      {'label': 'Other', 'value': 5.0, 'color': Colors.green},
    ];
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
            const Text('Service Breakdown', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87)),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: PieChart(
                PieChartData(
                  sections: data.map((d) {
                    return PieChartSectionData(
                      color: d['color'] as Color,
                      value: d['value'] as double,
                      title: '',
                      radius: 60,
                    );
                  }).toList(),
                  sectionsSpace: 2,
                  centerSpaceRadius: 0,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: data.map((d) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 12, height: 12, color: d['color'] as Color),
                    const SizedBox(width: 4),
                    Text('${d['label']} ${(d['value'] as double?)?.toInt() ?? 0}%', style: TextStyle(color: d['color'] as Color)),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
} 