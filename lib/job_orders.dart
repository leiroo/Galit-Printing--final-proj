import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'sidebar.dart';

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

class JobOrdersTable extends StatefulWidget {
  final List<Map<String, dynamic>> orders;
  final void Function(String orderId)? onViewDetails;
  final void Function(String orderId)? onAccept;
  final void Function(String orderId)? onReject;
  const JobOrdersTable({
    super.key,
    required this.orders,
    this.onViewDetails,
    this.onAccept,
    this.onReject,
  });

  @override
  State<JobOrdersTable> createState() => _JobOrdersTableState();
}

class _JobOrdersTableState extends State<JobOrdersTable> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedStatus = 'All Orders';
  List<Map<String, dynamic>> _filteredOrders = [];

  @override
  void initState() {
    super.initState();
    _filteredOrders = List.from(widget.orders);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterOrders() {
    setState(() {
      _filteredOrders = widget.orders.where((order) {
        final searchTerm = _searchController.text.toLowerCase();
        final statusFilter = _selectedStatus == 'All Orders' || order['status'] == _selectedStatus;
        final searchFilter = searchTerm.isEmpty || 
                           order['id'].toLowerCase().contains(searchTerm) ||
                           order['service'].toLowerCase().contains(searchTerm);
        return statusFilter && searchFilter;
      }).toList();
    });
  }



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;
    
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 16, vertical: isMobile ? 8 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Title
            Padding(
              padding: EdgeInsets.only(left: isMobile ? 8 : 16, top: 24, bottom: 8),
              child: Text(
                'Job Orders',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: isMobile ? 24 : 32,
                  color: Colors.black87,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: isMobile ? 8 : 16, bottom: 16),
              child: Text(
                'Manage and track all printing job orders with real-time status updates',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: isMobile ? 14 : 16,
                ),
              ),
            ),
            
            // Order Management Header Card
            Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
              ),
              margin: EdgeInsets.only(bottom: 24, left: isMobile ? 8 : 16, right: isMobile ? 8 : 16),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16.0 : 32.0, 
                  vertical: isMobile ? 20.0 : 32.0
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Management', 
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: isMobile ? 18 : 24, 
                        color: Colors.black87
                      )
                    ),
                    const SizedBox(height: 16),
                    
                    // Search and Filter Section
                    if (isMobile) ...[
                      // Mobile Layout
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Search field
                          TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              _filterOrders();
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: 'Search by order ID or service type',
                              filled: true,
                              fillColor: Color(0xFFF8FAFC),
                              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                          const SizedBox(height: 12),
                                                            // Status filter dropdown
                                  DropdownButtonFormField<String>(
                                    value: _selectedStatus,
                                    items: const [
                                      DropdownMenuItem(value: 'All Orders', child: Text('All Orders')),
                                      DropdownMenuItem(value: 'Completed', child: Text('Completed')),
                                      DropdownMenuItem(value: 'In Progress', child: Text('In Progress')),
                                      DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                                      DropdownMenuItem(value: 'Delayed', child: Text('Delayed')),
                                      DropdownMenuItem(value: 'Cancelled', child: Text('Cancelled')),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedStatus = value!;
                                        _filterOrders();
                                      });
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFF8FAFC),
                                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                        ],
                      ),
                    ] else ...[
                      // Desktop/Tablet Layout
                      Row(
                        children: [
                          // Search field
                          Expanded(
                            flex: 2,
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                _filterOrders();
                              },
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.search),
                                hintText: 'Search by order ID or service type',
                                filled: true,
                                fillColor: Color(0xFFF8FAFC),
                                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                          // Status filter dropdown
                          SizedBox(
                            width: isTablet ? 160 : 180,
                            child: DropdownButtonFormField<String>(
                              value: _selectedStatus,
                              items: const [
                                DropdownMenuItem(value: 'All Orders', child: Text('All Orders')),
                                DropdownMenuItem(value: 'Completed', child: Text('Completed')),
                                DropdownMenuItem(value: 'In Progress', child: Text('In Progress')),
                                DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                                DropdownMenuItem(value: 'Delayed', child: Text('Delayed')),
                                DropdownMenuItem(value: 'Cancelled', child: Text('Cancelled')),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedStatus = value!;
                                  _filterOrders();
                                });
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFF8FAFC),
                                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                    ],
                  ],
                ),
              ),
            ),
            
            // Job Orders Table Card
            Card(
              color: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
              ),
              margin: EdgeInsets.only(bottom: 24, left: isMobile ? 8 : 16, right: isMobile ? 8 : 16),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16.0 : 32.0, 
                  vertical: isMobile ? 20.0 : 32.0
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order List', 
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: isMobile ? 18 : 20, 
                        color: Colors.black87
                      )
                    ),
                    const SizedBox(height: 16),
                    
                    // Responsive Data Table
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: isMobile ? screenWidth - 48 : 800,
                        ),
                        child: DataTable(
                          headingRowColor: WidgetStateProperty.resolveWith<Color?>((states) => Colors.white),
                          headingTextStyle: TextStyle(
                            fontWeight: FontWeight.bold, 
                            color: Colors.black87, 
                            fontSize: isMobile ? 13 : 15
                          ),
                          dataRowColor: WidgetStateProperty.resolveWith<Color?>((states) {
                            if (states.contains(WidgetState.hovered)) {
                              return const Color(0xFFF1F5F9);
                            }
                            return Colors.white;
                          }),
                          columnSpacing: isMobile ? 32 : 64,
                          horizontalMargin: isMobile ? 16 : 32,
                          dataRowMinHeight: isMobile ? 48 : 56,
                          dataRowMaxHeight: isMobile ? 56 : 64,
                          columns: [
                            DataColumn(label: Text('Order ID', style: TextStyle(fontSize: isMobile ? 12 : 14))),
                            DataColumn(label: Text('Customer Name', style: TextStyle(fontSize: isMobile ? 12 : 14))),
                            DataColumn(label: Text('Service', style: TextStyle(fontSize: isMobile ? 12 : 14))),
                            DataColumn(label: Text('Date', style: TextStyle(fontSize: isMobile ? 12 : 14))),
                            DataColumn(label: Text('Status', style: TextStyle(fontSize: isMobile ? 12 : 14))),
                            DataColumn(label: Text('Price', style: TextStyle(fontSize: isMobile ? 12 : 14))),
                          ],
                          rows: _filteredOrders.map((order) {
                            Color statusColor;
                            switch (order['status']) {
                              case 'Completed':
                                statusColor = Colors.green;
                                break;
                              case 'In Progress':
                                statusColor = Colors.orange;
                                break;
                              case 'Pending':
                                statusColor = Colors.blue;
                                break;
                              case 'Delayed':
                                statusColor = Colors.red;
                                break;
                              case 'Cancelled':
                                statusColor = Colors.grey;
                                break;
                              default:
                                statusColor = Colors.grey;
                            }
                            
                            return DataRow(cells: [
                              DataCell(Text(
                                order['id'], 
                                style: TextStyle(fontSize: isMobile ? 11 : 13)
                              )),
                              DataCell(Text(
                                order['customer'], 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isMobile ? 11 : 13
                                )
                              )),
                              DataCell(Text(
                                order['service'], 
                                style: TextStyle(fontSize: isMobile ? 11 : 13)
                              )),
                              DataCell(Text(
                                order['date'], 
                                style: TextStyle(fontSize: isMobile ? 11 : 13)
                              )),
                              DataCell(Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 6 : 8, 
                                  vertical: isMobile ? 3 : 4
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  order['status'], 
                                  style: TextStyle(
                                    color: statusColor,
                                    fontSize: isMobile ? 10 : 12
                                  )
                                ),
                              )),
                              DataCell(Text(
                                order['price'], 
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isMobile ? 11 : 13
                                )
                              )),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color iconColor) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Icon(icon, color: iconColor, size: 28),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 