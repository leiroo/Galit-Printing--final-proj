import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

// Profile Menu Component
class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  void _handleMenuSelection(BuildContext context, String value) {
    switch (value) {
      case 'profile':
      case 'settings':
        // Both profile and settings go to settings page
        Navigator.pushReplacementNamed(context, '/settings');
        break;
      case 'logout':
        // Show logout confirmation dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Logout'),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                    Navigator.pushReplacementNamed(context, '/login'); // Go to login
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Logout'),
                ),
              ],
            );
          },
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    if (isMobile) {
      return PopupMenuButton<String>(
        icon: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.deepPurple,
          backgroundImage: const AssetImage('assets/logo.jpg'),
          child: null,
        ),
        onSelected: (value) => _handleMenuSelection(context, value),
        itemBuilder: (context) => [
          PopupMenuItem(value: 'profile', child: ListTile(leading: const Icon(Icons.person), title: const Text('Your Profile'))),
          PopupMenuItem(value: 'settings', child: ListTile(leading: const Icon(Icons.settings), title: const Text('Settings'))),
          PopupMenuItem(value: 'logout', child: ListTile(leading: const Icon(Icons.logout), title: const Text('Logout'))),
        ],
      );
    }
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.deepPurple,
          backgroundImage: const AssetImage('assets/logo.jpg'),
          child: null,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'System Administrator', 
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleMedium?.color,
              )
            ),
            Text(
              'Administrator', 
              style: TextStyle(
                fontSize: 12, 
                color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[400] : Colors.grey
              )
            ),
          ],
        ),
        const SizedBox(width: 8),
        PopupMenuButton<String>(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[400] : Colors.grey,
          ),
          onSelected: (value) => _handleMenuSelection(context, value),
          itemBuilder: (context) => [
            PopupMenuItem(value: 'profile', child: ListTile(leading: const Icon(Icons.person), title: const Text('Your Profile'))),
            PopupMenuItem(value: 'settings', child: ListTile(leading: const Icon(Icons.settings), title: const Text('Settings'))),
            PopupMenuItem(value: 'logout', child: ListTile(leading: const Icon(Icons.logout), title: const Text('Logout'))),
          ],
        ),
      ],
    );
  }
}

// Sidebar Component
class Sidebar extends StatelessWidget {
  final bool collapsed;
  final VoidCallback? onCollapse;
  const Sidebar({super.key, this.collapsed = false, this.onCollapse});

  @override
  Widget build(BuildContext context) {
    final String? currentRoute = ModalRoute.of(context)?.settings.name;
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Container(
      width: collapsed ? 72 : 260,
      color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF1E293B) : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            const SizedBox(height: 20),
            if (!collapsed)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Circular Logo Area
                    Center(
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF2563EB),
                          border: Border.all(color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF1E293B) : Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/logo.jpg',
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'GALIT Digital Printing Services',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Job Order Management System',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[400] : Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            if (!collapsed) const SizedBox(height: 8),
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
              onTap: () {
                if (currentRoute != '/inventory') {
                  Navigator.pushReplacementNamed(context, '/inventory');
                }
              },
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
              ],
            ),
          ),
          if (!collapsed)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Divider(color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[700] : Colors.grey[300]),
                  const SizedBox(height: 8),
                  // Theme Toggle Button
                  _SidebarItem(
                    icon: themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    label: themeProvider.isDarkMode ? 'Light Mode' : 'Dark Mode',
                    active: false,
                    collapsed: collapsed,
                    onTap: () {
                      themeProvider.toggleTheme();
                    },
                  ),
                  _SidebarItem(
                    icon: Icons.settings,
                    label: 'Settings',
                    active: currentRoute == '/settings',
                    collapsed: collapsed,
                    onTap: () {
                      if (currentRoute != '/settings') {
                        Navigator.pushReplacementNamed(context, '/settings');
                      }
                    },
                  ),
                  _SidebarItem(
                    icon: Icons.logout,
                    label: 'Logout',
                    active: false,
                    collapsed: collapsed,
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                  const SizedBox(height: 20),
                ],
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
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.collapsed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: collapsed ? 16 : 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: active 
                  ? (Theme.of(context).brightness == Brightness.dark ? Colors.blue[900] : Colors.blue[50]) 
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: active 
                      ? const Color(0xFF2563EB) 
                      : (Theme.of(context).brightness == Brightness.dark ? Colors.grey[400] : Colors.grey[600]),
                  size: 20,
                ),
                if (!collapsed) ...[
                  const SizedBox(width: 12),
                  Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: active 
                          ? const Color(0xFF2563EB) 
                          : (Theme.of(context).brightness == Brightness.dark ? Colors.grey[400] : Colors.grey[600]),
                      fontSize: 15,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
} 