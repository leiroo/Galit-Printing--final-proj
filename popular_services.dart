import 'package:flutter/material.dart';

class PopularServices extends StatelessWidget {
  const PopularServices({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {'name': 'Tarpaulin Printing', 'icon': Icons.print, 'percent': 32, 'color': Colors.blue},
      {'name': 'Business Cards', 'icon': Icons.credit_card, 'percent': 24, 'color': Colors.indigo},
      {'name': 'Sticker Printing', 'icon': Icons.sticky_note_2, 'percent': 18, 'color': Colors.green},
      {'name': 'ID Cards', 'icon': Icons.badge, 'percent': 14, 'color': Colors.orange},
      {'name': 'Booklet Printing', 'icon': Icons.menu_book, 'percent': 12, 'color': Colors.purple},
    ];
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Popular Services', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87)),
                DropdownButton<String>(
                  value: 'This Month',
                  items: const [DropdownMenuItem(value: 'This Month', child: Text('This Month'))],
                  onChanged: (v) {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...services.map((service) => _buildService(service)),
          ],
        ),
      ),
    );
  }

  Widget _buildService(Map service) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(service['icon'], color: service['color']),
          const SizedBox(width: 12),
          Expanded(child: Text(service['name'])),
          SizedBox(
            width: 120,
            child: LinearProgressIndicator(
              value: (service['percent'] as int) / 100,
              backgroundColor: Colors.grey[200],
              color: service['color'],
            ),
          ),
          const SizedBox(width: 12),
          Text('${service['percent']}%', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
} 