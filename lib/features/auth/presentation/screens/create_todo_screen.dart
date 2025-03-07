import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';

class CreateTodoScreen extends StatelessWidget {
  final TodoController todoController = Get.find();
  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create To-Do')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'To-Do Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String title = titleController.text.trim();
                if (title.isNotEmpty) {
                  todoController.addTodo(title);
                  Get.back(); // Close the screen after adding
                }
              },
              child: Text('Add To-Do'),
            ),
          ],
        ),
      ),
    );
  }
}
