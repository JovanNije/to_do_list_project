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
  // List to store tasks
  List<String> tasks = [];

  // Text editing controller to get input from TextField
  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('To-Do List'),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Simple TextField with decoration
              TextField(
                controller: taskController,
                decoration: const InputDecoration(
                  labelText: 'Enter Task', // Label above the input field
                  border: OutlineInputBorder(), // Border around the input field
                ),
                onChanged: (value) {
                  // This is triggered when the text in the TextField changes
                  print('Entered text: $value');
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(tasks[index]), // Display task in ListTile
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
                if (taskController.text.isNotEmpty) {
              setState(() {
                tasks.add(taskController.text); // Add task to list
                taskController.clear(); // Clear the text field
              });
               print("Task Added");
               }
          },   
          backgroundColor: Color(0xFF42A5F5), // Color of the FAB
          child: const Icon(Icons.add), // Icon for adding tasks
        ),
      ),
    );
  }
}
