import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    if (isMobile) {
      return PopupMenuButton<String>(
        icon: CircleAvatar(
          backgroundColor: Colors.deepPurple,
          child: Text('SA', style: TextStyle(color: Colors.white)),
        ),
        itemBuilder: (context) => [
          PopupMenuItem(value: 'profile', child: ListTile(leading: Icon(Icons.person), title: Text('Your Profile'))),
          PopupMenuItem(value: 'settings', child: ListTile(leading: Icon(Icons.settings), title: Text('Settings'))),
          PopupMenuItem(value: 'logout', child: ListTile(leading: Icon(Icons.logout), title: Text('Logout'))),
        ],
      );
    }
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.deepPurple,
          child: Text('SA', style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('System Administrator', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Administrator', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        const SizedBox(width: 8),
        PopupMenuButton<String>(
          icon: Icon(Icons.keyboard_arrow_down),
          itemBuilder: (context) => [
            PopupMenuItem(value: 'profile', child: ListTile(leading: Icon(Icons.person), title: Text('Your Profile'))),
            PopupMenuItem(value: 'settings', child: ListTile(leading: Icon(Icons.settings), title: Text('Settings'))),
            PopupMenuItem(value: 'logout', child: ListTile(leading: Icon(Icons.logout), title: Text('Logout'))),
          ],
        ),
      ],
    );
  }
} 