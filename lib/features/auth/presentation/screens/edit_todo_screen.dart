import 'package:auth_app1/features/auth/data/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';

class EditTodoScreen extends StatelessWidget {
  final TodoController todoController = Get.find();
  final TextEditingController titleController = TextEditingController();

  final Todo? oldTodo;

  Todo? currentTodo;
  EditTodoScreen({this.oldTodo});

  @override
  Widget build(BuildContext context) {
    if (oldTodo != null) {
      //  final oldTodo = Get.arguments as Todo;
      currentTodo = todoController.todos.value.firstWhere(
        (todo) => todo.id == oldTodo!.id,
      );
      titleController.text = currentTodo!.title;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(oldTodo == null ? 'Create To-Do' : 'Edit To-Do'),
      ),
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
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 12.0,
                ),
              ),
              maxLines: 10,
              textAlignVertical: TextAlignVertical.top,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String title = titleController.text.trim();

                if (oldTodo == null) {
                  if (title.isNotEmpty) {
                    todoController.addTodo(title);
                  }
                } else {
                  // if (title.isNotEmpty) {
                  todoController.updateWholeTodo(
                    oldTodo!,
                    currentTodo!.copyWith(title: title),
                  );
                  // }
                }
                Get.back();
              },
              child: Text(oldTodo == null ? 'Add To-Do' : 'Update To-Do'),
            ),
          ],
        ),
      ),
    );
  }
}
