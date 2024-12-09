import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 16, vertical: 20), // Padding for content
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Aligns all text to start
          children: [
            Text(
              '"To affect the quality of the day, that is the highest of arts. Every man is tasked to make his life, even in its details, worthy of the contemplation of his most elevated and critical hour."',
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.normal,
                height: 1.5, // Line height for better readability
              ),
            ),
            SizedBox(height: 16), // Space between the quote and the attribution
            Align(
              alignment: Alignment.centerRight, // Aligns text to the right
              child: Text(
                '— Henry David Thoreau',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
