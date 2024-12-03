import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: MainApp())); // Ensure MaterialApp is the root widget
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // List to store tasks along with their random background colors
  List<Map<String, dynamic>> tasks = [];

  // Controller to manage TextField input
  TextEditingController taskController = TextEditingController();

  // Variable to keep track of the selected task index
  int? selectedIndex;

  // Function to generate random bright colors
  Color _generateRandomBrightColor() {
    final random = Random();
    int red = random.nextInt(106) + 150;
    int green = random.nextInt(106) + 150;
    int blue = random.nextInt(106) + 150;
    return Color.fromRGBO(red, green, blue, 1);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        floatingActionButton: _buildFloatingActionButtons(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('To-Do List'),
      backgroundColor: Colors.blue,
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
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Padding inside the TextField
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
                selectedIndex = index; // Select the task
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0), // Space between tasks
              child: ListTile(
                tileColor: selectedIndex == index
                    ? Colors.grey[300] // Highlight selected task
                    : task['color'], // Use task's background color
                title: Text(task['task']),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFloatingActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0), // Padding below the buttons
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
    );
  }

  void _addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        tasks.add({
          'task': taskController.text,
          'color': _generateRandomBrightColor(),
        });
        taskController.clear();
        selectedIndex = null; // Clear the selection after adding a new task
      });
    }
  }

  void _deleteTask() {
    if (selectedIndex != null) {
      setState(() {
        tasks.removeAt(selectedIndex!); // Remove the selected task
        selectedIndex = null; // Clear the selection after deletion
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
      // Pre-fill the dialog's text field with the current task text
      final TextEditingController editController =
          TextEditingController(text: tasks[selectedIndex!]['task']);

      // Show dialog for editing the task
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Edit Task',
              style: TextStyle(
                color: Colors.purple, // Title color
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
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red, // Red background for Cancel button
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.white, // White text
                    fontWeight: FontWeight.bold, // Bold text
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    // Update the task with the new text
                    tasks[selectedIndex!]['task'] = editController.text;
                  });
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green, // Green background for OK button
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.white, // White text
                    fontWeight: FontWeight.bold, // Bold text
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      // Optional: Show a snackbar or message if no task is selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No task selected for editing."),
        ),
      );
    }
  }
}
