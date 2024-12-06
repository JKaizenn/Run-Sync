import 'package:flutter/material.dart';
import '../widgets/app_navigation_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Run Sync'),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu), // Hamburger menu icon
                onPressed: () {
                  Scaffold.of(context).openEndDrawer(); // Open drawer from the right
                },
              );
            },
          ),
        ],
      ),
      endDrawer: const AppNavigationDrawer(), // Drawer widget
      body: const Center(
        child: Text('Home Page Content'), // Replace with actual content
      ),
    );
  }
}
