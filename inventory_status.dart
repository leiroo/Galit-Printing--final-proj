import 'package:flutter/material.dart';

class InventoryStatus extends StatelessWidget {
  const InventoryStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'name': 'Ink - Magenta', 'percent': 0.67},
      {'name': 'Black Ink', 'percent': 0.80},
      {'name': 'Glossy Photo Paper', 'percent': 0.94},
      {'name': 'A4 Bond Paper', 'percent': 1.0},
      {'name': 'Tarpaulin Material (Matte)', 'percent': 1.0},
    ];
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Inventory Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            const Text('All inventory items at healthy levels', style: TextStyle(color: Colors.green)),
            const SizedBox(height: 16),
            ...items.map((item) => _buildItem(item['name'] as String, item['percent'] as double)),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Manage Inventory'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String name, double percent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          const Icon(Icons.circle, color: Colors.green, size: 12),
          const SizedBox(width: 8),
          Expanded(child: Text(name)),
          const SizedBox(width: 8),
          Text('${(percent * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          SizedBox(
            width: 120,
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: Colors.grey[200],
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('Good', style: TextStyle(color: Colors.green, fontSize: 12)),
          ),
        ],
      ),
    );
  }
} 