import 'package:flutter/material.dart';
import '../screens/about_screen.dart'; // Import the AboutScreen

class AppNavigationDrawer extends StatelessWidget {
  const AppNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
               // Updated color
            ),
            child: const Text(
              ' ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
              ),
            ),
          ),
          // Add space below the header
          const SizedBox(height: 20), // Adjust height as needed
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Handle settings tap
              // Future: Navigate to Settings Page
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
