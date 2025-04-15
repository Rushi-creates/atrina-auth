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
    //  final oldTodo = Get.arguments as Todo;
    var currentTodo = todoController.todos.value.firstWhere((todo) => todo.id == oldTodo.id);
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
                  todoController.updateWholeTodo(oldTodo,currentTodo.copyWith(title: title) );  
                  Get.back(); 
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
