import 'dart:math';
import 'package:flutter/material.dart';
import 'AboutMePage.dart';
import 'FavoritesPage.dart';
void main() {
  runApp(const MaterialApp(home: MainApp(), debugShowCheckedModeBanner: false, )); // Ensure MaterialApp is the root widget
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // List to store tasks along with their random background colors and favorite status
  List<Map<String, dynamic>> tasks = [];

  // List to store favorite tasks
  List<Map<String, dynamic>> favoriteTasks = [];

  // Controller to manage TextField input
  TextEditingController taskController = TextEditingController();

  // Variable to keep track of the selected task index
  int? selectedIndex;
  bool isNightMode = false;

  // Function to generate random bright colors
  Color _generateRandomBrightColor() {
    final random = Random();
    int red = random.nextInt(106) + 150;
    int green = random.nextInt(106) + 150;
    int blue = random.nextInt(106) + 150;
    return Color.fromRGBO(red, green, blue, 1);
  }

  // Function to toggle the favorite state of a task
  void _toggleFavorite(int index) {
    setState(() {
      tasks[index]['isFavorite'] = !tasks[index]['isFavorite'];

      // Add/remove task to/from the favoriteTasks list
      if (tasks[index]['isFavorite']) {
        favoriteTasks.add(tasks[index]);
      } else {
        favoriteTasks.remove(tasks[index]);
      }
    });
  }

  // Navigate to Home or Favorites page
  void _navigateToPage(String page) {
  if (page == 'Home') {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => MainApp()),
    );
  } else if (page == 'Favorites') {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => FavoritesPage(favoriteTasks: favoriteTasks, isNightMode:  isNightMode)),
    );
  } else if (page == 'Aboutme') {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AboutMePage(isNightMode: isNightMode)),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButtons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: _buildDrawer(), // Add Drawer (sidebar)
       backgroundColor: isNightMode ? Colors.grey[850] : Colors.white, // Dark gray for night mode, white for day mode
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('To-Do List'),
      backgroundColor: Colors.blue,
      // Use Builder to get the correct context to open the Drawer
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Opens the Drawer when clicked
            },
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTaskInputField(),
          const SizedBox(height: 20),
          _buildTaskList(),
        ],
      ),
    );
  }

  Widget _buildTaskInputField() {
    return TextField(
      controller: taskController,
      decoration: const InputDecoration(
        labelText: 'Enter Task',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
    );
  }

  Widget _buildTaskList() {
    return Expanded(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ListTile(
                tileColor: selectedIndex == index
                    ? Colors.grey[300]
                    : task['color'],
                title: Row(
                  children: [
                    Expanded(child: Text(task['task'])),
                    IconButton(
                      onPressed: () => _toggleFavorite(index),
                      icon: Icon(
                        task['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                        color: task['isFavorite'] ? Colors.red : Colors.black,
                      ),
                      iconSize: 30,
                      padding: const EdgeInsets.all(0),
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

Widget _buildFloatingActionButtons() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20.0),
    child: Row(
      children: [
        // This Expanded widget will allow the buttons to stay centered
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: _addTask,
                backgroundColor: const Color(0xFF42A5F5),
                child: const Icon(Icons.add),
              ),
              const SizedBox(width: 20),
              FloatingActionButton(
                onPressed: _editTask,
                backgroundColor: const Color.fromRGBO(171, 71, 188, 1),
                child: const Icon(Icons.edit),
              ),
              const SizedBox(width: 20),
              FloatingActionButton(
                onPressed: _deleteTask,
                backgroundColor: const Color(0xFFEF5350),
                child: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
        // Night Mode Toggle Button with 20px padding from the right
        Padding(
          padding: const EdgeInsets.only(right: 20.0),  // Add 20px padding
          child: FloatingActionButton(
            onPressed: _toggleNightMode,
            backgroundColor: isNightMode ? Colors.blue : Colors.grey, // Blue when night mode is on, grey when off
            child: Icon(
              isNightMode ? Icons.nightlight_round : Icons.wb_sunny,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildDrawer() {
  return Drawer(
    child: Container(
      color: isNightMode ? Colors.grey[850] : Colors.white, // Change background color based on night mode
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue, // Fixed color for the header
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Home',
              style: TextStyle(color: isNightMode ? Colors.white : Colors.black), // Change text color based on night mode
            ),
            onTap: () {
              _navigateToPage('Home');
            },
          ),
          ListTile(
            title: Text(
              'Favorites',
              style: TextStyle(color: isNightMode ? Colors.white : Colors.black), // Change text color based on night mode
            ),
            onTap: () {
              _navigateToPage('Favorites');
            },
          ),
          ListTile(
            title: Text(
              'About Me',
              style: TextStyle(color: isNightMode ? Colors.white : Colors.black), // Change text color based on night mode
            ),
            onTap: () {
              _navigateToPage('Aboutme');
            },
          ),
        ],
      ),
    ),
  );
}


  void _addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        tasks.add({
          'task': taskController.text,
          'color': _generateRandomBrightColor(),
          'isFavorite': false,
        });
        taskController.clear();
        selectedIndex = null;
      });
    }
  }

  void _deleteTask() {
    if (selectedIndex != null) {
      setState(() {
        tasks.removeAt(selectedIndex!);
        selectedIndex = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No task selected for deletion."),
        ),
      );
    }
  }

  void _editTask() {
    if (selectedIndex != null) {
      final TextEditingController editController =
          TextEditingController(text: tasks[selectedIndex!]['task']);

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Edit Task',
              style: TextStyle(
                color: Colors.purple,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: TextField(
              controller: editController,
              decoration: const InputDecoration(
                labelText: 'Task Name',
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    tasks[selectedIndex!]['task'] = editController.text;
                  });
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No task selected for editing."),
        ),
      );
    }
  }

  void _toggleNightMode() {
  setState(() {
    isNightMode = !isNightMode; // Toggle the value of isNightMode
  });
}
}
