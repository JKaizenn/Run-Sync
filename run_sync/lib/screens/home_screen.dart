import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:run_sync/screens/upload_page.dart';
import '../widgets/app_navigation_drawer.dart';
import '../widgets/workout_log.dart';
import 'add_page.dart';  
import 'upload_page.dart';

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
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.arrow_upward),
            label: 'Upload',
          ),
        ],
        currentIndex: 1, // Set the default selected tab index (e.g., Home is selected here)
        onTap: (index) {
          if (index == 0) {
            // Navigate to AddPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddPage()),
            );
          } else if (index == 1) {
            // Stay on Home screen (do nothing)
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UploadPage()),   
            );
            // Add logic for Upload screen if needed
          }
        },
      ),
    );
  }
}
