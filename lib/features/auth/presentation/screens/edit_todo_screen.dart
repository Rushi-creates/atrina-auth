import 'package:auth_app1/features/auth/data/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';

class EditTodoScreen extends StatelessWidget {
  final TodoController todoController = Get.find();
  final TextEditingController titleController = TextEditingController();

  final Todo oldTodo;

  EditTodoScreen({required this.oldTodo});

  @override
  Widget build(BuildContext context) {
    // Load the current title of the todo item
    var currentTodo = todoController.todos.value.firstWhere((todo) => todo.id == oldTodo.id);

    // Initialize the controller with the current title
    titleController.text = currentTodo.title;

    return Scaffold(
      appBar: AppBar(title: Text('Edit To-Do')),
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
                // if (title.isNotEmpty) {
                  todoController.updateWholeTodo(oldTodo,currentTodo.copyWith(title: title) );  // Update the todo
                  Get.back(); // Close the screen after updating
                // }
              },
              child: Text('Update To-Do'),
            ),
          ],
        ),
      ),
    );
  }
}
