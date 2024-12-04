import 'package:flutter/material.dart';

class AboutMePage extends StatelessWidget {
  final bool isNightMode; // Add this property

  const AboutMePage({Key? key, required this.isNightMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Me')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hi, I am Jovan Lontos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isNightMode ? Colors.white : Colors.black, // Change text color
              ),
            ),
            SizedBox(height: 16),
            Text(
              'I am a passionate developer.',
              style: TextStyle(
                fontSize: 18,
                color: isNightMode ? Colors.white : Colors.black, // Change text color
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Skills & Expertise:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isNightMode ? Colors.white : Colors.black, // Change text color
              ),
            ),
            SizedBox(height: 8),
            Text(
              '- Flutter\n- Dart',
              style: TextStyle(
                fontSize: 18,
                color: isNightMode ? Colors.white : Colors.black, // Change text color
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Feel free to reach out to me via email: jovan123413513@email.com',
              style: TextStyle(
                fontSize: 18,
                color: isNightMode ? Colors.white : Colors.black, // Change text color
              ),
            ),
          ],
        ),
      ),
      backgroundColor: isNightMode ? Colors.grey[850] : Colors.white, // Background color change
    );
  }
}
