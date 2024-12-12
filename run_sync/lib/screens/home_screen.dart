import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:run_sync/screens/upload_page.dart';
import '../widgets/app_navigation_drawer.dart';
import '../widgets/workout_log.dart';
import 'add_page.dart';
import 'upload_page.dart';

class Workout {
  final String title;
  final DateTime date;
  final int duration; // Duration in minutes
  final double distance; // Distance in miles

  Workout({
    required this.title,
    required this.date,
    required this.duration,
    required this.distance,
  });

  factory Workout.fromFirestore(Map<String, dynamic> data) {
    return Workout(
      title: data['title'] ?? 'Untitled',
      date: (data['date'] as Timestamp).toDate(),
      duration: int.tryParse(data['duration'].toString()) ?? 0,
      distance: (data['distance'] ?? 0.0).toDouble(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            );
          },
        ),
        title: Text(
          'Run Tracker',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://w7.pngwing.com/pngs/340/946/png-transparent-avatar-user-computer-icons-software-developer-avatar-child-face-heroes-thumbnail.png'),
            ),
          ),
        ],
      ),
      endDrawer: const AppNavigationDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: StreamBuilder<List<Workout>>(
          stream: getWorkoutsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading workouts.'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No workouts logged yet.'));
            }

            var workouts = snapshot.data!;
            workouts.sort((a, b) => b.date.compareTo(a.date)); // Sort latest to oldest

            final currentMonth = DateTime.now().month;
            final currentYear = DateTime.now().year;

            // Get list of days the user ran this month
            final runningDays = workouts
                .where((w) =>
                    w.date.month == currentMonth && w.date.year == currentYear)
                .map((w) => w.date.day)
                .toSet();

            // Create the calendar grid
            final daysInMonth = DateUtils.getDaysInMonth(currentYear, currentMonth);
            final firstDayOfWeek = DateTime(currentYear, currentMonth, 1).weekday;

            // Adjust starting position for the grid
            final List<int?> calendarDays = List.generate(
              firstDayOfWeek - 1,
              (_) => null,
            )..addAll(List.generate(daysInMonth, (i) => i + 1));

            return Column(
              children: [
                // Calendar Grid
                Wrap(
                  spacing: 2.0, // Reduced spacing between the squares
                  runSpacing: 2.0, // Reduced spacing between rows
                  children: calendarDays.map((day) {
                    if (day == null) {
                      // Empty slot for alignment
                      return const SizedBox(width: 30, height: 30); // Smaller size for empty space
                    }
                    final isRunningDay = runningDays.contains(day);
                    return Container(
                      width: 30, // Smaller box size
                      height: 30,
                      decoration: BoxDecoration(
                        color: isRunningDay ? Colors.orange : Colors.grey[800],
                        borderRadius: BorderRadius.circular(4), // Slightly rounded corners
                        border: isRunningDay
                            ? Border.all(color: Colors.black, width: 1.5) // Border for running days
                            : null,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Workout Cards Section
                Expanded(
                  child: ListView.builder(
                    itemCount: workouts.length,
                    itemBuilder: (context, index) {
                      final workout = workouts[index];
                      return Card(
                        elevation: 6, // Increased elevation for depth
                        margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), // Increased border radius
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.white, Colors.grey[100]!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16), // Match card radius
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 20.0,
                            ),
                            title: Text(
                              workout.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                                      const SizedBox(width: 6),
                                      Text(
                                        DateFormat('MMM d, yyyy').format(workout.date),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.directions_run, size: 16, color: Colors.grey),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Distance: ${workout.distance.toStringAsFixed(2)} miles',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.timer, size: 16, color: Colors.grey),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Duration: ${workout.duration} mins',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
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
            icon: Icon(Icons.upload),
            label: 'Upload',
          ),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UploadPage()),
            );
          }
        },
      ),
    );
  }
}
