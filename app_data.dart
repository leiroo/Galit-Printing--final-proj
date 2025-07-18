class Order {
  final String id;
  final String customer;
  final String service;
  final DateTime date;
  final String status;
  final double price;
  final int createdBy;

  Order({
    required this.id,
    required this.customer,
    required this.service,
    required this.date,
    required this.status,
    required this.price,
    required this.createdBy,
  });
}

class Payment {
  final String id;
  final String orderId;
  final DateTime date;
  final double amount;
  final String method;
  final String status;
  final int receivedBy;

  Payment({
    required this.id,
    required this.orderId,
    required this.date,
    required this.amount,
    required this.method,
    required this.status,
    required this.receivedBy,
  });
}

class InventoryItem {
  final String name;
  double stock;
  final double minStock;

  InventoryItem({required this.name, required this.stock, required this.minStock});
}

class Staff {
  final int id;
  final String name;
  final String role;

  Staff({required this.id, required this.name, required this.role});
}

class AppData {
  static List<Order> orders = [
    Order(id: 'JO-2044401', customer: 'ABC Corporation', service: 'banner_printing', date: DateTime(2025, 7, 17), status: 'Completed', price: 8500, createdBy: 1),
    Order(id: 'JO-701050', customer: 'ABC Corporation', service: 'tarpaulin_printing', date: DateTime(2025, 7, 17), status: 'Completed', price: 1200, createdBy: 1),
    Order(id: 'JO-799910', customer: 'ABC Corporation', service: 'photo_printing', date: DateTime(2025, 7, 17), status: 'In Progress', price: 750, createdBy: 2),
    Order(id: 'JO-199382', customer: 'ABC Corporation', service: 'banner_printing', date: DateTime(2025, 7, 17), status: 'In Progress', price: 2800, createdBy: 1),
    Order(id: 'JO-298527', customer: 'ABC Corporation', service: 'business_cards', date: DateTime(2025, 7, 17), status: 'Pending', price: 1500, createdBy: 2),
    Order(id: 'JO-461239', customer: 'ABC Corporation', service: 'sticker_printing', date: DateTime(2025, 7, 17), status: 'Pending', price: 6000, createdBy: 2),
    Order(id: 'JO-519447', customer: 'ABC Corporation', service: 'large_format_printing', date: DateTime(2025, 7, 17), status: 'Delayed', price: 3600, createdBy: 1),
    Order(id: 'JO-552838', customer: 'ABC Corporation', service: 'flyer_printing', date: DateTime(2025, 7, 17), status: 'Cancelled', price: 2500, createdBy: 1),
  ];

  static List<Payment> payments = [
    Payment(id: 'REC-000001', orderId: 'JO-2044401', date: DateTime(2025, 7, 17), amount: 8500, method: 'Cash', status: 'Completed', receivedBy: 2),
    Payment(id: 'REC-000002', orderId: 'JO-701050', date: DateTime(2025, 7, 17), amount: 1200, method: 'GCash', status: 'Completed', receivedBy: 1),
    Payment(id: 'REC-000003', orderId: 'JO-799910', date: DateTime(2025, 7, 17), amount: 750, method: 'Cash', status: 'Partial', receivedBy: 2),
    Payment(id: 'REC-000004', orderId: 'JO-199382', date: DateTime(2025, 7, 17), amount: 2800, method: 'Cash', status: 'Partial', receivedBy: 1),
    Payment(id: 'REC-000005', orderId: 'JO-298527', date: DateTime(2025, 7, 17), amount: 1500, method: 'GCash', status: 'Partial', receivedBy: 2),
    Payment(id: 'REC-000006', orderId: 'JO-461239', date: DateTime(2025, 7, 17), amount: 6000, method: 'Cash', status: 'Partial', receivedBy: 2),
    Payment(id: 'REC-000007', orderId: 'JO-519447', date: DateTime(2025, 7, 17), amount: 3600, method: 'Cash', status: 'Refunded', receivedBy: 1),
    Payment(id: 'REC-000008', orderId: 'JO-552838', date: DateTime(2025, 7, 17), amount: 2500, method: 'Cash', status: 'Refunded', receivedBy: 1),
  ];

  static List<InventoryItem> inventory = [
    InventoryItem(name: 'Tarpaulin Material', stock: 50, minStock: 10),
    InventoryItem(name: 'Ink - Magenta', stock: 20, minStock: 5),
    InventoryItem(name: 'Glossy Photo Paper', stock: 100, minStock: 20),
    InventoryItem(name: 'A4 Bond Paper', stock: 200, minStock: 50),
    InventoryItem(name: 'Sticker Paper', stock: 80, minStock: 15),
  ];

  static List<Staff> staff = [
    Staff(id: 1, name: 'Juan Dela Cruz', role: 'Admin'),
    Staff(id: 2, name: 'Maria Santos', role: 'Clerk'),
  ];
} 