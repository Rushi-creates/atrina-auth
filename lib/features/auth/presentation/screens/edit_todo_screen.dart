import 'package:auth_app1/features/auth/data/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/todo_controller.dart';

class EditTodoScreen extends GetView<TodoController> {
  // final TodoController todoController = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

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
              String desc = descController.text.trim();

              if (oldTodo == null) {
                if (title.isNotEmpty) {
                  controller.addTempTodo(title, desc, null);
                }
                controller.addTodosFromTemp();
              } else {
                controller.updateWholeTodo(
                  oldTodo!,
                  currentTodo!.copyWith(title: title),
                );
              }

              controller.removeAllTempTodo();
              Get.back();
            },
            child: Text(oldTodo == null ? 'Confirm' : 'Update To-Do'),
          ), // : SizedBox(),
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
                maxLines: 5,
                textAlignVertical: TextAlignVertical.top,
              ),
              SizedBox(height: 20),
              TextField(
                controller: descController,
                decoration: InputDecoration(
                  labelText: 'To-Do description',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 12.0,
                  ),
                ),
                maxLines: 5,
                textAlignVertical: TextAlignVertical.top,
              ),
              SizedBox(height: 20),
              Card(
                color: Colors.deepPurpleAccent,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.todoPriority.value = 3;
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  border:
                                      controller.todoPriority.value == 3
                                          ? Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          )
                                          : null,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'High',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            VerticalDivider(color: Colors.white),
                            InkWell(
                              onTap: () {
                                controller.todoPriority.value = 2;
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  border:
                                      controller.todoPriority.value == 2
                                          ? Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          )
                                          : null,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'Med',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            VerticalDivider(color: Colors.white),
                            InkWell(
                              onTap: () {
                                controller.todoPriority.value = 1;
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  border:
                                      controller.todoPriority.value == 1
                                          ? Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          )
                                          : null,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'Low',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              ////
              ///
              ///
              SizedBox(height: 20),
              Obx(() {
                return InkWell(
                  onTap: () async {
                    DateTime now = DateTime.now();
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: controller.todoDeadline.value ?? now,
                      firstDate: now,
                      lastDate: DateTime(now.year + 5),
                    );
                    if (picked != null) {
                      controller.todoDeadline.value = picked;
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 12.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.todoDeadline.value != null
                              ? DateFormat.yMMMd().format(
                                controller.todoDeadline.value!,
                              )
                              : 'Select Deadline',
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(Icons.calendar_today, size: 20),
                      ],
                    ),
                  ),
                );
              }),

              if (oldTodo == null)
                ElevatedButton(
                  onPressed: () {
                    String title = titleController.text.trim();
                    String desc = descController.text.trim();
                    controller.addTempTodo(title, desc, null);
                    titleController.clear();
                    descController.clear();

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
