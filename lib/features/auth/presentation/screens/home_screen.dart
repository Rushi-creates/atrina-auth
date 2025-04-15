// lib/screens/home_screen.dart
import 'package:auth_app1/config/flavor_config.dart';
import 'package:auth_app1/config/routes.dart';
import 'package:auth_app1/features/auth/data/models/profile.dart';
import 'package:auth_app1/features/auth/domain/repos.dart';
import 'package:auth_app1/features/auth/domain/utils/common_functions.dart';
import 'package:auth_app1/features/auth/domain/utils/common_widgets.dart';
import 'package:auth_app1/features/auth/presentation/controllers/home_controller.dart';
import 'package:auth_app1/features/auth/presentation/screens/create_todo_screen.dart';
import 'package:auth_app1/features/auth/presentation/screens/edit_todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:
      // themeController.themes[themeController.themeIndex].cardColor,
      appBar: AppBar(
        //   backgroundColor:
        // themeController.themes[themeController.themeIndex].cardColor,
        title: Text('Hive list', style: TextStyle(fontFamily: 'Roboto')),
        centerTitle: true,
        leading: Obx(
          () => Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(controller.todoController.todoCount.toString()),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              Get.toNamed(postView);
              // await authController.logout();
              // await userProfileSpRepo.remove();
              // setInitialScreen();
            },
            icon: Icon(Icons.pages),
          ),
          IconButton(
            onPressed: () async {
              Get.toNamed(profileView);
              // await authController.logout();
              // await userProfileSpRepo.remove();
              // setInitialScreen();
            },
            icon: Icon(Icons.person),
          ),
          IconButton(
            onPressed: () async {
              // await authController.logout();
              await userProfileSpRepo.remove();
              setInitialScreen();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              UserProfile? profile =
                  controller.profileController.getUserProfile();
              print('==---------------- ${profile.toString()}');

              if (profile?.id == null) {
                return Center(child: CircularProgressIndicator());
              } else if (profile != null) {
                print('=---------------- ${profile.toString()}');
                print('=---------------- ${profile!.id.toString()}');
                print('=---------------- ${profile.name.toString()}');
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Flavor is ${FlavorConfig.instance.name}'),
                      SizedBox(height: 8),
                      // Profile Image
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            profile!.profilePictureUrl.isNotEmpty
                                ? NetworkImage(profile.profilePictureUrl)
                                : AssetImage('assets/default_profile.png')
                                    as ImageProvider,
                        backgroundColor: Colors.grey[300],
                      ),
                      SizedBox(height: 16),

                      // Name
                      Text(
                        profile.name,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),

                      // Bio
                      // Text(
                      //   profile.bio,
                      //   style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      //   textAlign: TextAlign.center,
                      // ),
                      // SizedBox(height: 16),

                      // Image URL (Optional)
                      // Text(
                      //   "Profile Picture URL:",
                      //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      // ),
                      // Text(
                      //   profile.profilePictureUrl,
                      //   style: TextStyle(fontSize: 14, color: Colors.blue),
                      //   overflow: TextOverflow.ellipsis,
                      //   maxLines: 1,
                      // ),
                    ],
                  ),
                );
              }
              return SizedBox(height: 10);
            }),

            Obx(() {
              if (controller.todoController.todos.value.isEmpty) {
                return Center(
                  child: Text('No to-dos yet!', style: TextStyle(fontSize: 18)),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.todoController.todos.value.length,
                itemBuilder: (context, index) {
                  final todo = controller.todoController.todos.value[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      onTap: () {
                        Get.to(() => EditTodoScreen(oldTodo: todo));
                        // Get.toNamed(editTodoView, arguments: todo);
                      },
                      leading: Checkbox(
                        value: todo.isDone,
                        onChanged: (value) {
                          controller.todoController.updateTodoStatus(
                            todo.id,
                            value!,
                          );
                        },
                      ),
                      title: Text(
                        todo.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          decoration:
                              todo.isDone
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                        ),
                      ),
                      // subtitle: Text(todo.createdAt.toIso8601String()),
                      subtitle: Text(
                        DateFormat.yMMMd().add_jm().format(todo.createdAt),
                      ),

                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          todo.isDone
                              ? controller.todoController.deleteTodo(todo.id)
                              : Get.snackbar(
                                'Cant delete',
                                'Complete a todo first, in order to delete it',
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.red,
                              );
                        },
                      ),
                    ),
                  );
                },
              );
            }),

            // Obx(() {
            //   if (todoController.todos.isEmpty) {
            //     return Center(
            //       child: Text('No to-dos yet!', style: TextStyle(fontSize: 18)),
            //     );
            //   }
            //   return ListView.builder(
            //     itemCount: todoController.todos.length,
            //     itemBuilder: (context, index) {
            //       final todo = todoController.todos[index];
            //       return Card(
            //         margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            //         child: ListTile(
            //           leading: Checkbox(
            //             value: todo.isDone,
            //             onChanged: (value) {
            //               todoController.updateTodoStatus(todo.id, value!);
            //             },
            //           ),
            //           title: Text(
            //             todo.title,
            //             style: TextStyle(
            //               decoration: todo.isDone
            //                   ? TextDecoration.lineThrough
            //                   : TextDecoration.none,
            //             ),
            //           ),
            //           trailing: IconButton(
            //             icon: Icon(Icons.delete, color: Colors.red),
            //             onPressed: () {
            //               todoController.deleteTodo(todo.id);
            //             },
            //           ),
            //         ),
            //       );
            //     },
            //   );
            // }),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Card(
            //   color: Colors.deepPurpleAccent,
            //   child: Padding(
            //     padding: const EdgeInsets.all(6.0),
            //     child: SizedBox(
            //       height: 40,
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Row(
            //           children: [
            //             InkWell(
            //               onTap: () {
            //                 FlavorConfig(flavor: Flavor.dev);
            //               },
            //               child: Text('Dev'),
            //             ),
            //             VerticalDivider(color: Colors.white),
            //             InkWell(
            //               onTap: () {
            //                 FlavorConfig(flavor: Flavor.prod);
            //               },
            //               child: Text('Prod'),
            //             ),
            //             VerticalDivider(color: Colors.white),

            //             InkWell(
            //               onTap: () {
            //                 FlavorConfig(flavor: Flavor.qa);
            //               },
            //               child: Text('Qa'),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Spacer(),
            Card(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: IconButton(
                  onPressed: () async {
                    Get.defaultDialog(
                      title: "Are you sure?",
                      middleText: "This will delete all your completed todos",
                      textConfirm: "OK",
                      textCancel: "Cancel",
                      onConfirm: () {
                        controller.todoController.deleteCompletedTodos();
                        Get.back();
                      },
                    );
                  },
                  icon: Icon(Icons.delete_forever, size: 25),
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                Get.to(() => EditTodoScreen());
                // Get.to(() => CreateTodoScreen());
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
