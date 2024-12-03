import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteTasks;

  const FavoritesPage({Key? key, required this.favoriteTasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favoriteTasks.isEmpty
          ? const Center(child: Text('No favorite tasks yet!'))
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
    );
  }
}
