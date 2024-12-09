import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

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
}

// Workout History Widget
class WorkoutLog extends StatelessWidget {
  final List<Workout> previousWorkouts;

  const WorkoutLog({super.key, required this.previousWorkouts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Workout History",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(),
        // Expanded widget ensures the ListView.builder is scrollable and fits properly
        Expanded(
          child: ListView.builder(
            itemCount: previousWorkouts.length,
            itemBuilder: (context, index) {
              final workout = previousWorkouts[index];
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
  }
}

// Helper method to show the overlay
void showWorkoutOverlay(BuildContext context, List<Workout> workouts) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        child: WorkoutLog(previousWorkouts: workouts),
      );
    },
  );
}
