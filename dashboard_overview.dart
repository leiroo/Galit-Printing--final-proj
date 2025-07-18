import 'package:flutter/material.dart';
// If you have google_fonts in your pubspec.yaml, uncomment the next line:
// import 'package:google_fonts/google_fonts.dart';

class DashboardOverview extends StatelessWidget {
  const DashboardOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final cards = [
      _buildCard(
        title: 'Pending Orders',
        value: '2',
        icon: Icons.access_time_outlined,
        statusIcon: Icons.arrow_upward,
        statusColor: Colors.green,
        subtitle: '15% from last week',
        semanticLabel: 'Pending Orders',
        isMobile: isMobile,
      ),
      _buildCard(
        title: 'Completed Orders',
        value: '2',
        icon: Icons.check_circle_outline,
        statusIcon: Icons.arrow_upward,
        statusColor: Colors.red,
        subtitle: '8% from last week',
        semanticLabel: 'Completed Orders',
        isMobile: isMobile,
      ),
      _buildCard(
        title: "Today's Revenue",
        value: '₱0',
        icon: Icons.receipt_long,
        statusIcon: Icons.arrow_upward,
        statusColor: Colors.green,
        subtitle: '12% from yesterday',
        semanticLabel: "Today's Revenue",
        isMobile: isMobile,
      ),
      _buildCard(
        title: 'Low Stock Items',
        value: '0',
        icon: Icons.inventory_2_outlined,
        statusIcon: Icons.error_outline,
        statusColor: Colors.blue,
        subtitle: 'Restock needed',
        semanticLabel: 'Low Stock Items',
        isMobile: isMobile,
      ),
    ];
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 6 : 16, vertical: isMobile ? 8 : 16),
        child: isMobile
            ? Wrap(
                spacing: 8,
                runSpacing: 8,
                children: cards.map((c) => SizedBox(
                  width: (MediaQuery.of(context).size.width / 2) - 16,
                  child: c,
                )).toList(),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: cards
                    .map((c) => Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: c)))
                    .toList(),
              ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String value,
    required IconData icon,
    required IconData statusIcon,
    required Color statusColor,
    required String subtitle,
    required String semanticLabel,
    required bool isMobile,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(vertical: isMobile ? 6 : 12, horizontal: isMobile ? 2 : 8),
        child: Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                    fontSize: 15,
                    letterSpacing: 0.1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                // Value and Icon Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          height: 1.1,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: Icon(icon, color: Colors.black87, size: 28, semanticLabel: semanticLabel),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                // Centered subtitle/status
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(statusIcon, color: statusColor, size: 16, semanticLabel: subtitle),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          subtitle,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.visible,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 