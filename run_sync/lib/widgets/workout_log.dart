import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Firestore

// Workout class to represent each workout
class Workout {
  final String title;
  final DateTime date;
  final int duration; // Duration in minutes
  final double distance; // Distance in miles
  final String pacePerMile; // Pace in "min/mile"

  Workout({
    required this.title,
    required this.date,
    required this.duration,
    required this.distance,
  }) : pacePerMile = _calculatePacePerMile(distance, duration);

  // Factory method to create a Workout from Firestore document
  factory Workout.fromFirestore(Map<String, dynamic> data) {
    return Workout(
      title: data['title'] ?? 'Untitled',
      date: (data['date'] as Timestamp).toDate(),
      duration: int.tryParse(data['duration'].toString()) ?? 0,
      distance: (data['distance'] ?? 0.0).toDouble(), // Distance is stored as miles in Firestore
    );
  }

  // Calculate pace per mile
  static String _calculatePacePerMile(double distanceMiles, int durationMinutes) {
    if (distanceMiles <= 0) return 'N/A';
    double paceMinutesPerMile = durationMinutes / distanceMiles;

    int minutes = paceMinutesPerMile.floor();
    int seconds = ((paceMinutesPerMile - minutes) * 60).round();
    return '${minutes}:${seconds.toString().padLeft(2, '0')} min/mile';
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
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(DateFormat.yMMMd().format(workout.date)),
                          Text('Distance: ${workout.distance.toStringAsFixed(2)} miles'),
                          Text('Pace: ${workout.pacePerMile}'),
                        ],
                      ),
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
