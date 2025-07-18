import 'package:flutter/material.dart';

class RecentOrders extends StatelessWidget {
  const RecentOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: isMobile ? 6 : 0),
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Text('Recent Orders', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: TextButton(onPressed: () {}, child: const Text('View All', style: TextStyle(color: Colors.black54))),
                ),
              ],
            ),
            const SizedBox(height: 16),
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
                columnSpacing: isMobile ? 32 : 100,
                horizontalMargin: isMobile ? 6 : 50,
                dataRowMinHeight: 56,
                dataRowMaxHeight: 64,
                columns: const [
                  DataColumn(label: Text('Order ID')),
                  DataColumn(label: Text('Customer Name')),
                  DataColumn(label: Text('Service Type')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Price')),
                ],
                rows: [
                  _orderRow('JO-2044401', 'Juan Dela Cruz', 'banner_printing', 'Jul 17, 2025', 'Completed', '₱8,500', '1'),
                  _orderRow('JO-701050', 'Maria Santos', 'tarpaulin_printing', 'Jul 17, 2025', 'Completed', '₱1,200', '1'),
                  _orderRow('JO-799910', 'Pedro Reyes', 'photo_printing', 'Jul 17, 2025', 'In Progress', '₱750', '2'),
                  _orderRow('JO-199382', 'Ana Lim', 'banner_printing', 'Jul 17, 2025', 'In Progress', '₱2,800', '1'),
                  _orderRow('JO-298527', 'Liza Cruz', 'business_cards', 'Jul 17, 2025', 'Pending', '₱1,500', '2'),
                  _orderRow('JO-461239', 'Stacy Cruz', 'sticker_printing', 'Jul 17, 2025', 'Pending', '₱6,000', '2'),
                  _orderRow('JO-519447', 'Juan Dela Cruz', 'large_format_printing', 'Jul 17, 2025', 'Delayed', '₱3,600', '1'),
                  _orderRow('JO-552838', 'Maria Santos', 'flyer_printing', 'Jul 17, 2025', 'Cancelled', '₱2,500', '1'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _orderRow(String id, String customer, String service, String date, String status, String price, String createdBy) {
    Color statusColor;
    switch (status) {
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
      DataCell(Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Text(id, maxLines: 1, overflow: TextOverflow.ellipsis),
      )),
      DataCell(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customer, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
          Text('ID: $createdBy', style: const TextStyle(fontSize: 12, color: Colors.grey), maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      )),
      DataCell(Text(service, maxLines: 1, overflow: TextOverflow.ellipsis)),
      DataCell(Text(date, maxLines: 1, overflow: TextOverflow.ellipsis)),
      DataCell(Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: statusColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(status, style: TextStyle(color: statusColor), maxLines: 1, overflow: TextOverflow.ellipsis),
      )),
      DataCell(Text(price, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis)),
    ]);
  }
}

class JobOrdersTable extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 6 : 16, vertical: isMobile ? 8 : 16),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                // Page Title
                const Padding(
                  padding: EdgeInsets.only(left: 16, top: 24, bottom: 8),
                  child: Text(
                    'Job Orders',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 32,
                      color: Colors.black87,
                    ),
                  ),
                ),
                // Order Management Header in its own Card
                Card(
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
                  ),
                  margin: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Order Management', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black87)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            // Search bar
                            if (!isMobile)
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.search),
                                    hintText: 'Search by order ID or service type',
                                    filled: true,
                                    fillColor: Color(0xFFF8FAFC),
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
                            if (isMobile)
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAFC),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey[300]!),
                                ),
                                child: const Icon(Icons.search, color: Colors.black54),
                              ),
                            const SizedBox(width: 16),
                            // Status Filter
                            SizedBox(
                              width: 180,
                              child: DropdownButtonFormField<String>(
                                value: 'All Orders',
                                items: const [
                                  DropdownMenuItem(value: 'All Orders', child: Text('All Orders')),
                                  DropdownMenuItem(value: 'Completed', child: Text('Completed')),
                                  DropdownMenuItem(value: 'In Progress', child: Text('In Progress')),
                                  DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                                  DropdownMenuItem(value: 'Delayed', child: Text('Delayed')),
                                  DropdownMenuItem(value: 'Cancelled', child: Text('Cancelled')),
                                ],
                                onChanged: (v) {},
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFF8FAFC),
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
                            // More Filters Button
                            SizedBox(
                              width: 140,
                              child: OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.filter_alt_outlined, size: 20),
                                label: const Text('More Filters'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.black87,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  side: const BorderSide(color: Color(0xFFE5E7EB)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Job Orders Table in its own Card (improved to match header box)
                Card(
                  color: Colors.white,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
                  ),
                  margin: const EdgeInsets.only(top: 0, bottom: 32, left: 16, right: 16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
                    child: Container(
                      margin: EdgeInsets.zero,
                      child: SingleChildScrollView(
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
                          columnSpacing: 64,
                          horizontalMargin: 32,
                          dataRowMinHeight: 56,
                          dataRowMaxHeight: 64,
                          columns: const [
                            DataColumn(label: Text('Order ID')),
                            DataColumn(label: Text('Customer Name')),
                            DataColumn(label: Text('Service Type')),
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('Price')),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text('JO-2044401')),
                              DataCell(Text('Juan Dela Cruz', style: TextStyle(fontWeight: FontWeight.bold))),
                              DataCell(Text('banner_printing')),
                              DataCell(Text('Jul 17, 2025')),
                              DataCell(Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text('Completed', style: TextStyle(color: Colors.green)),
                              )),
                              DataCell(Text('₱8,500', style: TextStyle(fontWeight: FontWeight.bold))),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('JO-701050')),
                              DataCell(Text('Maria Santos', style: TextStyle(fontWeight: FontWeight.bold))),
                              DataCell(Text('tarpaulin_printing')),
                              DataCell(Text('Jul 17, 2025')),
                              DataCell(Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text('Completed', style: TextStyle(color: Colors.green)),
                              )),
                              DataCell(Text('₱1,200', style: TextStyle(fontWeight: FontWeight.bold))),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('JO-799910')),
                              DataCell(Text('Pedro Reyes', style: TextStyle(fontWeight: FontWeight.bold))),
                              DataCell(Text('photo_printing')),
                              DataCell(Text('Jul 17, 2025')),
                              DataCell(Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text('In Progress', style: TextStyle(color: Colors.orange)),
                              )),
                              DataCell(Text('₱750', style: TextStyle(fontWeight: FontWeight.bold))),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('JO-199382')),
                              DataCell(Text('Ana Lim', style: TextStyle(fontWeight: FontWeight.bold))),
                              DataCell(Text('flyer_printing')),
                              DataCell(Text('Jul 17, 2025')),
                              DataCell(Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text('Pending', style: TextStyle(color: Colors.blue)),
                              )),
                              DataCell(Text('₱2,800', style: TextStyle(fontWeight: FontWeight.bold))),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('JO-298527')),
                              DataCell(Text('Liza Cruz', style: TextStyle(fontWeight: FontWeight.bold))),
                              DataCell(Text('business_cards')),
                              DataCell(Text('Jul 17, 2025')),
                              DataCell(Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text('Cancelled', style: TextStyle(color: Colors.red)),
                              )),
                              DataCell(Text('₱1,500', style: TextStyle(fontWeight: FontWeight.bold))),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}