import 'package:flutter/material.dart';

class AIInsightsPredictions extends StatelessWidget {
  const AIInsightsPredictions({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('AI Insights & Predictions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _insightCard(
                    icon: Icons.trending_up,
                    title: 'Sales Forecast',
                    desc: 'Based on current trends, expect a 15% increase in tarpaulin printing orders next month. Consider increasing inventory levels.',
                    color: Colors.blue[50]!,
                    iconColor: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _insightCard(
                    icon: Icons.lightbulb_outline,
                    title: 'Efficiency Opportunity',
                    desc: 'Bundling business cards with flyers could increase average order value by 22%. Consider creating a promotional package.',
                    color: Colors.yellow[50]!,
                    iconColor: Colors.amber,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _insightCard(
                    icon: Icons.error_outline,
                    title: 'Potential Risk',
                    desc: 'Sticker production efficiency has dropped 8% in the last 2 weeks. Consider maintenance for the cutting machine.',
                    color: Colors.red[50]!,
                    iconColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _insightCard({required IconData icon, required String title, required String desc, required Color color, required Color iconColor}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Text(desc, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
} 