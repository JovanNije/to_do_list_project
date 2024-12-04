import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteTasks;
  final bool isNightMode; // Add this property

  const FavoritesPage({Key? key, required this.favoriteTasks, required this.isNightMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favoriteTasks.isEmpty
          ? Center(
              child: Text(
                'No favorite tasks yet!',
                style: TextStyle(
                  color: isNightMode ? Colors.white : Colors.black, // Change text color based on night mode
                ),
              ),
            )
          : ListView.builder(
              itemCount: favoriteTasks.length,
              itemBuilder: (context, index) {
                final task = favoriteTasks[index];
                return ListTile(
                  title: Text(task['task']),
                  tileColor: task['color'],
                );
              },
            ),
      backgroundColor: isNightMode ? Colors.grey[850] : Colors.white, // Background color change based on night mode
    );
  }
}
