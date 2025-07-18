import 'package:flutter/material.dart';

class RevenueTrend extends StatefulWidget {
  const RevenueTrend({super.key});

  @override
  State<RevenueTrend> createState() => _RevenueTrendState();
}

class _RevenueTrendState extends State<RevenueTrend> {
  int? selectedIndex;
  int _currentPage = 0;
  final PageController _pageController = PageController();

  final months = const [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];
  final values = const [
    32000, 25000, 30000, 40000, 37000, 34000,
    42000, 39000, 41000, 38000, 36000, 35000
  ];

  @override
  Widget build(BuildContext context) {
    int pageCount = (months.length / 4).ceil();
    final isMobile = MediaQuery.of(context).size.width < 600;
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
                const Text('Revenue Trend', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87)),
                DropdownButton<String>(
                  value: 'Monthly',
                  items: const [DropdownMenuItem(value: 'Monthly', child: Text('Monthly'))],
                  onChanged: (v) {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            isMobile
                ? Column(
                    children: [
                      SizedBox(
                        height: 180,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: pageCount,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemBuilder: (context, pageIndex) {
                            int start = pageIndex * 4;
                            int end = (start + 4).clamp(0, months.length);
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: List.generate(end - start, (i) {
                                int idx = start + i;
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = idx;
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        AnimatedContainer(
                                          duration: const Duration(milliseconds: 200),
                                          height: values[idx] / 700,
                                          width: 36,
                                          color: selectedIndex == idx ? Colors.orange : Colors.blue,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(months[idx]),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(pageCount, (index) => AnimatedContainer(
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
                : SizedBox(
                    height: 180,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(months.length, (i) {
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = i;
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  height: values[i] / 700,
                                  width: 36,
                                  color: selectedIndex == i ? Colors.orange : Colors.blue,
                                ),
                                const SizedBox(height: 8),
                                Text(months[i]),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
            if (selectedIndex != null) ...[
              const SizedBox(height: 16),
              Text(
                '${months[selectedIndex!]}: ₱${values[selectedIndex!].toString().replaceAllMapped(RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))"), (m) => "${m[1]},")}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.indigo),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 