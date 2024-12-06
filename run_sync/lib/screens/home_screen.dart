import 'package:flutter/material.dart';
import '../widgets/app_navigation_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String userProfileUrl = 'https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes-thumbnail.png'; // Replace with actual URL
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 10),
            CircleAvatar(
              backgroundImage: NetworkImage(userProfileUrl),
            ),
          ],
        ),
        actions: [
          Builder(
            builder: (context) {
                return Row(
                children: [
                  IconButton(
                  icon: const Icon(Icons.menu), // Hamburger menu icon
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer(); // Open drawer from the right
                  },
                  ),
                  const SizedBox(width: 10),
                ],
                );
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