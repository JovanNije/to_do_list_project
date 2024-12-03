import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
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

   // Function to generate random bright colors
  Color _generateRandomBrightColor() {
    final random = Random();
    // Generating bright colors by ensuring RGB values are higher (between 150 and 255)
    int red = random.nextInt(106) + 150;   // Random value between 150 and 255
    int green = random.nextInt(106) + 150; // Random value between 150 and 255
    int blue = random.nextInt(106) + 150;  // Random value between 150 and 255
    return Color.fromRGBO(red, green, blue, 1); // Full opacity
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
        floatingActionButton: _buildFloatingActionButtons(),
      ),
    );
  }

  // Builds the AppBar widget
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('To-Do List'),
      backgroundColor: const Color.fromARGB(255, 35, 149, 243),
    );
  }

  // Builds the body of the app
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildTaskInputField(),
          const SizedBox(height: 20), // Space between input field and task list
          _buildTaskList(),
        ],
      ),
    );
  }

  // Builds the TextField for task input
  Widget _buildTaskInputField() {
    return TextField(
      controller: taskController,
      decoration: const InputDecoration(
        labelText: 'Enter Task', // Label for the input field
        border: OutlineInputBorder(), // Border style for the field
      ),
      onChanged: (value) {
        // Prints entered text for debugging purposes
        print('Entered text: $value');
      },
    );
  }

  // Builds the ListView to display tasks
  Widget _buildTaskList() {
    return Expanded(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          // Retrieve the task and its associated background color
          final task = tasks[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0), // Padding between tasks
            child: ListTile(
              tileColor: task['color'], // Set background color for each task
              title: Text(task['task']), // Display task at this index
            ),
          );
        },
      ),
    );
  }

   Widget _buildFloatingActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Add Button
        FloatingActionButton(
          onPressed: _addTask,
          backgroundColor: const Color(0xFF42A5F5),
          child: const Icon(Icons.add),
        ),
        const SizedBox(width: 20), // Space between buttons
        // Edit Button
        FloatingActionButton(
          onPressed: _editTask,
          backgroundColor: const Color.fromARGB(255, 245, 149, 229),
          child: const Icon(Icons.edit),
        ),
        const SizedBox(width: 20), // Space between buttons
        // Delete Button
        FloatingActionButton(
          onPressed: _deleteTask,
          backgroundColor: const Color.fromARGB(255, 223, 82, 82),
          child: const Icon(Icons.delete),
        ),
      ],
    );
  }

  // Adds a task to the list with a random background color
  void _addTask() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        tasks.add({
          'task': taskController.text, // Add task text
          'color': _generateRandomBrightColor(), // Assign a random color to the task
        });
        taskController.clear(); // Clear the input field after adding task
      });
      print("Task Added");
    }
  }
    // Placeholder for editing a task
  void _editTask() {
    // Logic for editing a task will go here
    print("Edit Task");
  }

  // Placeholder for deleting a task
  void _deleteTask() {
    // Logic for deleting a task will go here
    print("Delete Task");
  }
}
