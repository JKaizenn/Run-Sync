import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Firestore

// Workout class to represent each workout
class Workout {
  final String title;
  final DateTime date;
  final int duration; // Duration in minutes

  Workout({
    required this.title,
    required this.date,
    required this.duration,
  });

  // Factory method to create a Workout from Firestore document
  factory Workout.fromFirestore(Map<String, dynamic> data) {
    return Workout(
      title: data['title'] ?? 'Untitled',
      date: (data['date'] as Timestamp).toDate(),
      duration: int.tryParse(data['duration'].toString()) ?? 0,
    );
  }
}

// Workout History Widget
class WorkoutLog extends StatelessWidget {
  final Stream<List<Workout>> workoutsStream;

  const WorkoutLog({Key? key, required this.workoutsStream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Workout>>(
      stream: workoutsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No workouts logged yet."));
        }

        final workouts = snapshot.data!;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Workout History",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: workouts.length,
                itemBuilder: (context, index) {
                  final workout = workouts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: ListTile(
                      title: Text(workout.title),
                      subtitle: Text(DateFormat.yMMMd().format(workout.date)),
                      trailing: Text("${workout.duration} mins"),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
