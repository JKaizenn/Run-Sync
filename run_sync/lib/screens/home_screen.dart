import 'package:flutter/material.dart';
import '../widgets/app_navigation_drawer.dart';
import '../widgets/workout_log.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample workout data
    final List<Workout> previousWorkouts = [
      Workout(
        title: "Morning Run",
        date: DateTime.now().subtract(Duration(days: 1)),
        duration: 30,
      ),
      Workout(
        title: "Evening Run",
        date: DateTime.now().subtract(Duration(days: 2)),
        duration: 45,
      ),
      Workout(
        title: "Treadmill Run",
        date: DateTime.now().subtract(Duration(days: 3)),
        duration: 25,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 10),
            CircleAvatar(
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
      // Embed the WorkoutLog directly in the body
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: WorkoutLog(previousWorkouts: previousWorkouts),
      ),
    );
  }
}
