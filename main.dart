import 'package:flutter/material.dart';
import 'login.dart';
import 'sidebar.dart';
import 'profile_menu.dart';
import 'dashboard_overview.dart';
import 'ai_insights.dart';
import 'recent_orders.dart';
import 'revenue_trend.dart';
import 'popular_services.dart';
import 'monthly_sales_chart.dart';
import 'revenue_trends_chart.dart';
import 'service_breakdown_chart.dart';
import 'app_data.dart';
import 'package:fl_chart/fl_chart.dart';

class JobOrdersPage extends StatelessWidget {
  const JobOrdersPage({super.key});
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final orders = AppData.orders.map((o) => {
      'id': o.id,
      'customer': o.customer,
      'service': o.service,
      'date': o.date.toLocal().toString().split(' ')[0],
      'status': o.status,
      'price': '₱${o.price.toStringAsFixed(0)}',
      'createdBy': o.createdBy,
    }).toList();
    return Scaffold(
      appBar: AppBar(
        leading: isMobile
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,
        title: const Text('Job Orders'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      drawer: isMobile ? const Drawer(child: Sidebar()) : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const Sidebar(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 6 : 32, vertical: 32),
              child: JobOrdersTable(orders: orders),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Color(0xFFF8FAFC),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const MyHomePage(title: 'Dashboard'),
        '/analytics': (context) => const AnalyticsPage(),
        '/payments': (context) => const PaymentsPage(),
        '/settings': (context) => const SettingsPage(),
        '/reports': (context) => const ReportsPage(),
        '/job-orders': (context) => const JobOrdersPage(),
        '/inventory': (context) => const InventoryPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      appBar: AppBar(
        leading: isMobile
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,
        title: Text(widget.title),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: ProfileMenu(),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      drawer: isMobile ? const Drawer(child: Sidebar()) : null,
      body: Column(
        children: [
          // Add a thin divider below the AppBar
          const Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isMobile) const Sidebar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 6 : 32, vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Dashboard Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                        const SizedBox(height: 16),
                        const DashboardOverview(),
                        const AIInsights(),
                        const RecentOrders(),
                        const SizedBox(height: 24),
                        const RevenueTrend(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Expanded(
                              flex: 1,
                              child: PopularServices(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      appBar: AppBar(
        leading: isMobile
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,
        title: const Text('Analytics'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: ProfileMenu(),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      drawer: isMobile ? const Drawer(child: Sidebar()) : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const Sidebar(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 6 : 32, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Analytics Dashboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  SizedBox(height: 24),
                  RevenueTrendsChart(),
                  SizedBox(height: 24),
                  ServiceBreakdownChart(),
                  SizedBox(height: 24),
                  MonthlySalesChart(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    final payments = [
      {
        'receipt': 'REC-000001',
        'order': 'JO-000001',
        'date': 'Jul 10, 2025',
        'amount': '₱8,500',
        'method': 'Cash',
        'status': 'Completed',
        'receivedBy': '2',
      },
      {
        'receipt': 'REC-000002',
        'order': 'JO-000001',
        'date': 'Jul 12, 2025',
        'amount': '₱1,200',
        'method': 'GCash',
        'status': 'Completed',
        'receivedBy': '1',
      },
      {
        'receipt': 'REC-000003',
        'order': 'JO-000001',
        'date': 'Jul 15, 2025',
        'amount': '₱400',
        'method': 'Cash',
        'status': 'Partial',
        'receivedBy': '2',
      },
    ];
    return Scaffold(
      appBar: AppBar(
        leading: isMobile
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,
        title: const Text('Payments'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ProfileMenu(),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      drawer: isMobile ? const Drawer(child: Sidebar()) : null,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 6 : 32, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Payment Management', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 20),
                  label: const Text('Record Payment', style: TextStyle(fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Card(
              color: const Color(0xFFF8FAFC),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Search by receipt ID or order ID',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFF2563EB)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 180,
                      child: DropdownButtonFormField<String>(
                        value: 'All Statuses',
                        items: const [
                          DropdownMenuItem(value: 'All Statuses', child: Text('All Statuses')),
                          DropdownMenuItem(value: 'Completed', child: Text('Completed')),
                          DropdownMenuItem(value: 'Partial', child: Text('Partial')),
                          DropdownMenuItem(value: 'Refunded', child: Text('Refunded')),
                        ],
                        onChanged: (v) {},
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFF2563EB)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 140,
                      child: DropdownButtonFormField<String>(
                        value: 'All Time',
                        items: const [
                          DropdownMenuItem(value: 'All Time', child: Text('All Time')),
                          DropdownMenuItem(value: 'Today', child: Text('Today')),
                          DropdownMenuItem(value: 'This Week', child: Text('This Week')),
                          DropdownMenuItem(value: 'This Month', child: Text('This Month')),
                        ],
                        onChanged: (v) {},
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFF2563EB)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Payment Transactions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                    const SizedBox(height: 8),
                    const Text('View and manage all payment records', style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Receipt #')),
                          DataColumn(label: Text('Order ID')),
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Amount')),
                          DataColumn(label: Text('Method')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Received By')),
                          DataColumn(label: Text('Actions')),
                        ],
                        rows: payments.map((p) {
                          Color statusColor;
                          String status = p['status']!;
                          switch (status) {
                            case 'Completed':
                              statusColor = const Color(0xFF4ADE80); // green
                              break;
                            case 'Partial':
                              statusColor = const Color(0xFFFACC15); // yellow
                              break;
                            case 'Refunded':
                              statusColor = const Color(0xFFF87171); // red
                              break;
                            default:
                              statusColor = Colors.grey;
                          }
                          return DataRow(cells: [
                            DataCell(Text(p['receipt']!)),
                            DataCell(Text(p['order']!)),
                            DataCell(Text(p['date']!)),
                            DataCell(Text(p['amount']!, style: const TextStyle(fontWeight: FontWeight.bold))),
                            DataCell(Text(p['method']!)),
                            DataCell(Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.w500)),
                            )),
                            DataCell(Text(p['receivedBy']!)),
                            DataCell(Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.receipt_long, color: Color(0xFF2563EB)),
                                  tooltip: 'View Receipt',
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.link, color: Colors.black54),
                                  tooltip: 'Copy Link',
                                  onPressed: () {},
                                ),
                              ],
                            )),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            isMobile
                ? Column(
                    children: [
                      // Payment Summary first, then Payment Methods
                      _paymentSummaryCard(),
                      const SizedBox(height: 24),
                      _paymentMethodsCard(),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Payment Summary left, Payment Methods right
                      Expanded(flex: 1, child: _paymentSummaryCard()),
                      const SizedBox(width: 24),
                      Expanded(flex: 1, child: _paymentMethodsCard()),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

Widget _summaryRow(String label, String value, {Color? color, bool bold = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: TextStyle(color: color ?? Colors.black)),
      Text(value, style: TextStyle(
        color: color ?? Colors.black,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        fontSize: bold ? 18 : 16,
      )),
    ],
  );
}

Widget _methodRow(IconData icon, String label, String amount, String percent, Color color, double progress) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      const SizedBox(height: 4),
      LinearProgressIndicator(
        value: progress,
        minHeight: 6,
        backgroundColor: color.withOpacity(0.1),
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
      const SizedBox(height: 2),
      Align(
        alignment: Alignment.centerRight,
        child: Text(percent, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ),
    ],
  );
}

Widget _paymentSummaryCard() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.calendar_today_outlined, size: 24),
              SizedBox(width: 8),
              Text('Payment Summary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ],
          ),
          const SizedBox(height: 24),
          _summaryRow('Today\'s Revenue', '₱12,500.00', bold: true),
          const SizedBox(height: 8),
          _summaryRow('This Week', '₱58,750.00'),
          const SizedBox(height: 8),
          _summaryRow('This Month', '₱245,320.00'),
          const Divider(height: 32),
          _summaryRow('Pending Payments', '₱35,200.00', color: Color(0xFFF59E42)),
          const SizedBox(height: 8),
          _summaryRow('Completed Payments', '₱210,120.00', color: Color(0xFF22C55E)),
        ],
      ),
    ),
  );
}

Widget _paymentMethodsCard() {
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
          Row(
            children: const [
              Icon(Icons.credit_card, size: 24, color: Colors.black87),
              SizedBox(width: 8),
              Text('Payment Methods', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87)),
            ],
          ),
          const SizedBox(height: 24),
          _methodRow(Icons.attach_money, 'Cash', '₱150,200.00', '65% of total', Colors.green, 0.65),
          const SizedBox(height: 16),
          _methodRow(Icons.account_balance_wallet, 'GCash', '₱58,500.00', '25% of total', Colors.blue, 0.25),
        ],
      ),
    ),
  );
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      appBar: AppBar(
        leading: isMobile
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,
        title: const Text('Settings'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: ProfileMenu(),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      drawer: isMobile ? const Drawer(child: Sidebar()) : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const Sidebar(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 6 : 32, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
                  const SizedBox(height: 8),
                  const Text('Manage your account and system preferences', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 24),
                  // Tabs
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Row(
                      children: [
                        _settingsTab('Account', true),
                        _settingsTab('Notifications', false),
                        _settingsTab('Appearance', false),
                        _settingsTab('System', false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Account Information Card
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Account Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                          const SizedBox(height: 4),
                          const Text('Update your personal information and password', style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Personal Information', style: TextStyle(fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        const Icon(Icons.person_outline, size: 20, color: Colors.grey),
                                        const SizedBox(width: 8),
                                        const Text('Full Name', style: TextStyle(fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: 'System Administrator',
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                        isDense: true,
                                        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 32),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 24),
                                    Row(
                                      children: [
                                        const Icon(Icons.email_outlined, size: 20, color: Colors.grey),
                                        const SizedBox(width: 8),
                                        const Text('Email Address', style: TextStyle(fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: 'admin@galitprinting.com',
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                        isDense: true,
                                        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          // Password Section
                          const Text('Password', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Current Password', style: TextStyle(fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 8),
                                    TextField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your current password',
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                        isDense: true,
                                        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 32),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('New Password', style: TextStyle(fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 8),
                                    TextField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: 'Enter new password',
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                        isDense: true,
                                        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 32),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Confirm New Password', style: TextStyle(fontWeight: FontWeight.w500)),
                                    const SizedBox(height: 8),
                                    TextField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: 'Confirm new password',
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                        isDense: true,
                                        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _settingsTab(String label, bool active) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
    child: Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: active ? const Color(0xFF2563EB) : Colors.grey[600],
        fontSize: 16,
      ),
    ),
  );
}

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final totalSales = AppData.payments.where((p) => p.status == 'Completed').fold<double>(0, (sum, p) => sum + p.amount);
    final totalProfit = totalSales * 0.25; // Example: 25% margin
    final salesByService = <String, double>{};
    for (final order in AppData.orders) {
      salesByService[order.service] = (salesByService[order.service] ?? 0) + order.price;
    }
    final salesByCustomer = <String, double>{};
    for (final order in AppData.orders) {
      salesByCustomer[order.customer] = (salesByCustomer[order.customer] ?? 0) + order.price;
    }
    return Scaffold(
      appBar: AppBar(
        leading: isMobile
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,
        title: const Text('Reports'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      drawer: isMobile ? const Drawer(child: Sidebar()) : null,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 6 : 32, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Admin Reports Dashboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
            const SizedBox(height: 4),
            const Text('Visible to: System Administrator only', style: TextStyle(color: Colors.red, fontSize: 14)),
            const SizedBox(height: 24),
            Row(
              children: [
                _reportCard('Total Sales', '₱${totalSales.toStringAsFixed(2)}', Icons.attach_money, Colors.blue),
                const SizedBox(width: 24),
                _reportCard('Total Profit', '₱${totalProfit.toStringAsFixed(2)}', Icons.trending_up, Colors.green),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Sales by Service', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 12),
            Container(
              height: 220,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE5E7EB)),
              ),
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: (salesByService.values.isNotEmpty ? salesByService.values.reduce((a, b) => a > b ? a : b) : 0) + 1000,
                  barTouchData: BarTouchData(enabled: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final keys = salesByService.keys.toList();
                          if (value.toInt() >= 0 && value.toInt() < keys.length) {
                            return Text(keys[value.toInt()], style: const TextStyle(fontSize: 12));
                          }
                          return const SizedBox.shrink();
                        },
                        interval: 1,
                      ),
                    ),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    for (int i = 0; i < salesByService.length; i++)
                      BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: salesByService.values.elementAt(i),
                            color: Colors.blueAccent,
                            width: 24,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text('Sales by Customer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 12),
            Container(
              height: 220,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Color(0xFFE5E7EB)),
              ),
              child: PieChart(
                PieChartData(
                  sections: [
                    for (int i = 0; i < salesByCustomer.length; i++)
                      PieChartSectionData(
                        color: Colors.primaries[i % Colors.primaries.length].shade300,
                        value: salesByCustomer.values.elementAt(i),
                        title: salesByCustomer.keys.elementAt(i),
                        radius: 60,
                        titleStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                  ],
                  sectionsSpace: 2,
                  centerSpaceRadius: 0,
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text('Sales by Service (Table)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 12),
            ...salesByService.entries.map((e) => ListTile(
              leading: const Icon(Icons.local_offer, color: Colors.indigo),
              title: Text(e.key),
              trailing: Text('₱${e.value.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
            )),
            const SizedBox(height: 32),
            const Text('Sales by Customer (Table)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 12),
            ...salesByCustomer.entries.map((e) => ListTile(
              leading: const Icon(Icons.person, color: Colors.deepPurple),
              title: Text(e.key),
              trailing: Text('₱${e.value.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
            )),
          ],
        ),
      ),
    );
  }
}

Widget _reportCard(String title, String value, IconData icon, Color color) {
  return Expanded(
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: color)),
          ],
        ),
      ),
    ),
  );
}

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final inventory = [
      {
        'id': '11',
        'name': 'Mugs',
        'desc': 'Coffee Wedding...',
        'stock': 100.0,
        'unit': '100',
        'reorder': 80.0,
        'cost': '₱150.00',
        'lead': '10 days',
        'status': 'Adequate',
      },
      {
        'id': '10',
        'name': 'Trophy Base (Marble)',
        'desc': 'Marble base for trophy construction...',
        'stock': 3.0,
        'unit': 'pieces',
        'reorder': 10.0,
        'cost': '₱150.00',
        'lead': '14 days',
        'status': 'Low Stock',
      },
      {
        'id': '9',
        'name': 'LED Module (5050)',
        'desc': 'LED modules for signage lighting...',
        'stock': 50.0,
        'unit': 'pieces',
        'reorder': 20.0,
        'cost': '₱25.00',
        'lead': '21 days',
        'status': 'Adequate',
      },
      {
        'id': '8',
        'name': 'DTF Transfer Film',
        'desc': 'Direct-to-film transfer material...',
        'stock': 12.0,
        'unit': 'meters',
        'reorder': 20.0,
        'cost': '₱95.00',
        'lead': '14 days',
        'status': 'Low Stock',
      },
      {
        'id': '7',
        'name': 'Vinyl Sticker Material',
        'desc': 'Adhesive vinyl for stickers and decals...',
        'stock': 8.0,
        'unit': 'meters',
        'reorder': 15.0,
        'cost': '₱75.00',
        'lead': '5 days',
        'status': 'Low Stock',
      },
      {
        'id': '6',
        'name': 'Sublimation Paper',
        'desc': 'Transfer paper for sublimation printing...',
        'stock': 200.0,
        'unit': 'sheets',
        'reorder': 50.0,
        'cost': '₱12.00',
        'lead': '7 days',
        'status': 'Adequate',
      },
      {
        'id': '5',
        'name': 'Cotton T-Shirt (White)',
        'desc': 'Plain white cotton t-shirt for sublimation...',
        'stock': 100.0,
        'unit': 'pieces',
        'reorder': 30.0,
        'cost': '₱85.00',
        'lead': '10 days',
        'status': 'Adequate',
      },
      {
        'id': '4',
        'name': 'Sintra Board (3mm)',
        'desc': '',
        'stock': 25.0,
        'unit': 'sheets',
        'reorder': 10.0,
        'cost': '₱125.00',
        'lead': '10 days',
        'status': 'Adequate',
      },
    ];
    return Scaffold(
      appBar: AppBar(
        leading: isMobile
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,
        title: const Text('Inventory Management'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      drawer: isMobile ? const Drawer(child: Sidebar()) : null,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 6 : 32, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Inventory Management', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            const SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.resolveWith<Color?>((states) => Colors.white),
                headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 15),
                dataRowColor: WidgetStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(WidgetState.hovered)) {
                    return const Color(0xFFF1F5F9);
                  }
                  return Colors.white;
                }),
                columnSpacing: 32,
                horizontalMargin: 24,
                dataRowMinHeight: 48,
                dataRowMaxHeight: 56,
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Item Name')),
                  DataColumn(label: Text('Current Stock')),
                  DataColumn(label: Text('Unit')),
                  DataColumn(label: Text('Reorder Level')),
                  DataColumn(label: Text('Unit Cost')),
                  DataColumn(label: Text('Lead Time')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: inventory.map((item) {
                  Color statusColor;
                  String statusLabel;
                  switch (item['status']) {
                    case 'Low Stock':
                      statusColor = Colors.orange;
                      statusLabel = 'Low Stock';
                      break;
                    case 'Adequate':
                    default:
                      statusColor = Colors.green;
                      statusLabel = 'Adequate';
                      break;
                  }
                  return DataRow(cells: [
                    DataCell(Text(item['id'].toString())),
                    DataCell(Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['name'].toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        if (item['desc'].toString().isNotEmpty)
                          Text(item['desc'].toString(), style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    )),
                    DataCell(Text(item['stock'].toString())),
                    DataCell(Text(item['unit'].toString())),
                    DataCell(Text(item['reorder'].toString())),
                    DataCell(Text(item['cost'].toString())),
                    DataCell(Text(item['lead'].toString())),
                    DataCell(Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(statusLabel, style: TextStyle(color: statusColor)),
                    )),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Color(0xFF6366F1)),
                          onPressed: () {},
                          tooltip: 'Edit',
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, color: Color(0xFF22C55E)),
                          onPressed: () {},
                          tooltip: 'Add Stock',
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh, color: Color(0xFF64748B)),
                          onPressed: () {},
                          tooltip: 'Restock',
                        ),
                      ],
                    )),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}