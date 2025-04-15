import 'package:auth_app1/features/auth/data/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/todo_controller.dart';

class EditTodoScreen extends GetView<TodoController> {
  // final TodoController todoController = Get.find();
  final TextEditingController titleController = TextEditingController();

  final Todo? oldTodo;

  Todo? currentTodo;
  EditTodoScreen({this.oldTodo});

  @override
  Widget build(BuildContext context) {
    if (oldTodo != null) {
      //  final oldTodo = Get.arguments as Todo;
      currentTodo = controller.todos.value.firstWhere(
        (todo) => todo.id == oldTodo!.id,
      );
      titleController.text = currentTodo!.title;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            controller.removeAllTempTodo();
            Get.back();
          },
        ),
        title: Text(oldTodo == null ? 'Create To-Do' : 'Edit To-Do'),
        actions: [
          // oldTodo == null
        ElevatedButton(
  onPressed: () {
    String title = titleController.text.trim();

    if (oldTodo == null) {
      // For creating new todos
      if (title.isNotEmpty) {
        // First add the current title as a temp todo
        print("Adding current title to temp todos");
        controller.addTempTodo(title);
      }
      
      // Then save all temp todos
      print("Now saving all temp todos: ${controller.tempTodos.value.length}");
      controller.addTodosFromTemp();
    } else {
      // For updating existing todo
      controller.updateWholeTodo(
        oldTodo!,
        currentTodo!.copyWith(title: title),
      );
    }
    
    controller.removeAllTempTodo();
    Get.back();
  },
  child: Text(oldTodo == null ? 'Confirm' : 'Update To-Do'),
),  // : SizedBox(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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

              if (oldTodo == null)
                ElevatedButton(
                  onPressed: () {
                    String title = titleController.text.trim();
                    controller.addTempTodo(title);
                    titleController.clear();

                    // Get.back();
                  },
                  child: Text(oldTodo == null ? 'Add To-Do' : 'Update To-Do'),
                ),

              if (oldTodo == null)
                Obx(() {
                  if (controller.tempTodos.value.isEmpty) {
                    return Center(
                      child: Text('', style: TextStyle(fontSize: 18)),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.tempTodos.value.length,
                    itemBuilder: (context, index) {
                      final todo = controller.tempTodos.value[index];
                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: ListTile(
                          // onTap: () {
                          //   Get.to(() => EditTodoScreen(oldTodo: todo));
                          //   // Get.toNamed(editTodoView, arguments: todo);
                          // },
                          // leading: Checkbox(
                          //   value: todo.isDone,
                          //   onChanged: (value) {
                          //     controller.updateTodoStatus(
                          //       todo.id,
                          //       value!,
                          //     );
                          //   },
                          // ),
                          title: Text(
                            todo.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(decoration: TextDecoration.none),
                          ),
                          // subtitle: Text(todo.createdAt.toIso8601String()),
                          subtitle: Text(
                            DateFormat.yMMMd().add_jm().format(todo.createdAt),
                          ),

                          trailing: IconButton(
                            icon: Icon(Icons.remove, color: Colors.red),
                            onPressed: () {
                              controller.removeTempTodo(index);
                            },
                          ),
                        ),
                      );
                    },
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}
