import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/app_navigation_drawer.dart';
import '../widgets/workout_log.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Fetch workouts from Firestore
  Stream<List<Workout>> getWorkoutsStream() {
    return FirebaseFirestore.instance
        .collection('workouts')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Workout.fromFirestore(doc.data());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: WorkoutLog(workoutsStream: getWorkoutsStream()),
      ),
    );
  }
}
