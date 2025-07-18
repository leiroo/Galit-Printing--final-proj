import 'package:flutter/material.dart';

class SidebarScaffold extends StatefulWidget {
  final Widget child;
  const SidebarScaffold({super.key, required this.child});

  @override
  State<SidebarScaffold> createState() => _SidebarScaffoldState();
}

class _SidebarScaffoldState extends State<SidebarScaffold> {
  bool _collapsed = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    if (isMobile) {
      // Mobile: Use Drawer
      return Scaffold(
        drawer: Drawer(
          child: Sidebar(
            collapsed: false,
            onCollapse: null,
          ),
        ),
        appBar: AppBar(
          title: const Text('Galit Digital Printing'),
        ),
        body: widget.child,
      );
    }
    // Desktop/Web: Collapsible sidebar
    return Row(
      children: [
        Sidebar(
          collapsed: _collapsed,
          onCollapse: () => setState(() => _collapsed = !_collapsed),
        ),
        Expanded(child: widget.child),
      ],
    );
  }
}

class Sidebar extends StatelessWidget {
  final bool collapsed;
  final VoidCallback? onCollapse;
  const Sidebar({super.key, this.collapsed = false, this.onCollapse});

  @override
  Widget build(BuildContext context) {
    final String? currentRoute = ModalRoute.of(context)?.settings.name;
    return Container(
      width: collapsed ? 72 : 260,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          if (!collapsed)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Galit Digital Printing',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Job Order Management System',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'System Administrator',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'Admin',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 32),
                ],
              ),
            ),
          if (!collapsed) const SizedBox(height: 16),
          _SidebarItem(
            icon: Icons.grid_view,
            label: 'Dashboard',
            active: currentRoute == '/dashboard',
            collapsed: collapsed,
            onTap: () {
              if (currentRoute != '/dashboard') {
                Navigator.pushReplacementNamed(context, '/dashboard');
              }
            },
          ),
          _SidebarItem(
            icon: Icons.assignment_outlined,
            label: 'Job Orders',
            active: currentRoute == '/job-orders',
            collapsed: collapsed,
            onTap: () {
              if (currentRoute != '/job-orders') {
                Navigator.pushReplacementNamed(context, '/job-orders');
              }
            },
          ),
          _SidebarItem(
            icon: Icons.inventory_2_outlined,
            label: 'Inventory',
            active: currentRoute == '/inventory',
            collapsed: collapsed,
            onTap: () {},
          ),
          _SidebarItem(
            icon: Icons.receipt_long,
            label: 'Payments',
            active: currentRoute == '/payments',
            collapsed: collapsed,
            onTap: () {
              if (currentRoute != '/payments') {
                Navigator.pushReplacementNamed(context, '/payments');
              }
            },
          ),
          _SidebarItem(
            icon: Icons.show_chart,
            label: 'Analytics',
            active: currentRoute == '/analytics',
            collapsed: collapsed,
            onTap: () {
              if (currentRoute != '/analytics') {
                Navigator.pushReplacementNamed(context, '/analytics');
              }
            },
          ),
          _SidebarItem(
            icon: Icons.insert_chart_outlined,
            label: 'Reports',
            active: currentRoute == '/reports',
            collapsed: collapsed,
            onTap: () {
              if (currentRoute != '/reports') {
                Navigator.pushReplacementNamed(context, '/reports');
              }
            },
          ),
          _SidebarItem(
            icon: Icons.settings_outlined,
            label: 'Settings',
            active: currentRoute == '/settings',
            collapsed: collapsed,
            onTap: () {
              if (currentRoute != '/settings') {
                Navigator.pushReplacementNamed(context, '/settings');
              }
            },
          ),
          const Spacer(),
          Divider(height: 1, color: Colors.grey),
          if (onCollapse != null)
            IconButton(
              icon: Icon(collapsed ? Icons.chevron_right : Icons.chevron_left),
              onPressed: onCollapse,
              tooltip: collapsed ? 'Expand' : 'Collapse',
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.indigo),
              title: collapsed ? null : const Text('Logout', style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final bool collapsed;
  final VoidCallback? onTap;
  const _SidebarItem({required this.icon, required this.label, this.active = false, this.collapsed = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: active ? const Color(0xFF2563EB) : Colors.grey[600],
          size: 22,
        ),
        title: collapsed
            ? null
            : Text(
                label,
                style: TextStyle(
                  fontWeight: active ? FontWeight.bold : FontWeight.normal,
                  color: active ? const Color(0xFF2563EB) : Colors.grey[800],
                  fontSize: 16,
                  // fontFamily: GoogleFonts.inter().fontFamily, // Uncomment if using google_fonts
                ),
              ),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: collapsed ? 16.0 : 24.0),
        minLeadingWidth: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        tileColor: active ? const Color(0xF0F5F9FF) : Colors.transparent,
        hoverColor: const Color(0xFFE5E7EB),
      ),
    );
  }
} 