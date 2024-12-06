import 'package:flutter/material.dart';
import '../widgets/app_navigation_drawer.dart';
import '../widgets/workout_log.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1; // Default to Home tab

  // Sample workout data
  final List<Workout> previousWorkouts = [
    Workout(
      title: "Morning Run",
      date: DateTime.now().subtract(const Duration(days: 1)),
      duration: 30,
    ),
    Workout(
      title: "Evening Run",
      date: DateTime.now().subtract(const Duration(days: 2)),
      duration: 45,
    ),
    Workout(
      title: "Treadmill Run",
      date: DateTime.now().subtract(const Duration(days: 3)),
      duration: 25,
    ),
  ];

  // Pages for each tab
  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    // Define the pages dynamically since `previousWorkouts` is used
    _pages.addAll([
      Center(child: Text('Add Page')), // Placeholder for Add tab
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: WorkoutLog(previousWorkouts: previousWorkouts), // Home tab
      ),
      Center(child: Text('Share Page')), // Placeholder for Share tab
    ]);
  }

  // Handle bottom bar navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 10),
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes-thumbnail.png'),
            ),
          ],
        ),
        actions: [
          Builder(
            builder: (context) {
              return Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                  const SizedBox(width: 10),
                ],
              );
            },
          ),
        ],
      ),
      endDrawer: const AppNavigationDrawer(),
      body: _pages[_selectedIndex], // Show the selected tab's page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Highlight the active tab
        onTap: _onItemTapped, // Handle tab switching
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Share',
          ),
        ],
        selectedItemColor: Colors.black, // Highlight color for selected tab
        unselectedItemColor: Colors.grey, // Color for unselected tabs
        showUnselectedLabels: true, // Display labels for all tabs
      ),
    );
  }
}
