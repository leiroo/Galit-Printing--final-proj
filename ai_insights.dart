import 'package:flutter/material.dart';
import 'dart:async';

class AIInsights extends StatefulWidget {
  const AIInsights({super.key});

  @override
  State<AIInsights> createState() => _AIInsightsState();
}

class _AIInsightsState extends State<AIInsights> {
  late final PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) return;
      setState(() {
        _currentPage = (_currentPage + 1) % 3;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final insights = [
      _buildInsight(
        Icons.trending_up,
        'Peak Hour Prediction',
        "Today's peak business hours are predicted between 2:00 PM - 5:00 PM. Consider allocating 2 additional staff members.",
        Colors.blue[50]!,
      ),
      _buildInsight(
        Icons.lightbulb,
        'Resource Optimization',
        'Tarpaulin printer #2 has 30% higher efficiency than #1. Prioritize high-volume orders on printer #2.',
        Colors.yellow[50]!,
      ),
      _buildInsight(
        Icons.warning,
        'Inventory Alert',
        'Cyan ink will reach critical levels in 4 days based on current usage patterns. Order soon to avoid delays.',
        Colors.green[50]!,
      ),
    ];
    return Card(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: MediaQuery.of(context).size.width < 600 ? 6 : 0),
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: isMobile
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 170,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      children: insights,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(insights.length, (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 16 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? Colors.indigo : Colors.grey[300],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    )),
                  ),
                ],
              )
            : Row(
                children: [
                  insights[0],
                  const SizedBox(width: 16),
                  insights[1],
                  const SizedBox(width: 16),
                  insights[2],
                ],
              ),
      ),
    );
  }

  Widget _buildInsight(IconData icon, String title, String desc, Color bg) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFFE5E7EB), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.black, size: 22),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            Text(desc, style: const TextStyle(fontSize: 13, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
} 