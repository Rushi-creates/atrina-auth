// lib/screens/home_screen.dart
import 'package:auth_app1/config/flavor_config.dart';
import 'package:auth_app1/features/auth/domain/repos.dart';
import 'package:auth_app1/features/auth/domain/utils/common_functions.dart';
import 'package:auth_app1/features/auth/presentation/controllers/auth_controller.dart';
import 'package:auth_app1/features/auth/presentation/controllers/profile_controller.dart';
import 'package:auth_app1/features/auth/presentation/controllers/theme_controller.dart';
import 'package:auth_app1/features/auth/presentation/screens/create_todo_screen.dart';
import 'package:auth_app1/features/auth/presentation/screens/edit_todo_screen.dart';
import 'package:auth_app1/features/auth/presentation/screens/post_screen.dart';
import 'package:auth_app1/features/auth/presentation/screens/profile_screen.dart';
import 'package:auth_app1/features/auth/presentation/screens/profile_screen_new.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/todo_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TodoController todoController = Get.put(TodoController());
  final AuthController authController = Get.find();
  final ProfileController profileController = Get.find();
  // final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:
      // themeController.themes[themeController.themeIndex].cardColor,
      appBar: AppBar(
      //   backgroundColor: 
      // themeController.themes[themeController.themeIndex].cardColor,
        
        title: Text('To-Do List', style: TextStyle(fontFamily: 'Roboto')),
        centerTitle: true,
        leading: Obx(
          () => Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(todoController.todoCount.toString()),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              Get.to(() => PostView());
              // await authController.logout();
              // await userProfileSpRepo.remove();
              // setInitialScreen();
            },
            icon: Icon(Icons.pages),
          ),
          IconButton(
            onPressed: () async {
              Get.to(() => ProfilePageNew());
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
              var profile = profileController.getUserProfile();

              if (profile == null) {
                return Center(child: CircularProgressIndicator());
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Flavor is ${FlavorConfig.instance.name}',
                    ),
                    SizedBox(height: 8),
                    // Profile Image
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          profile.profilePictureUrl.isNotEmpty
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

                    

                    // Bio (Uncomment if needed)
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
            }),

            Obx(() {
              if (todoController.todos.value.isEmpty) {
                return Center(
                  child: Text('No to-dos yet!', style: TextStyle(fontSize: 18)),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: todoController.todos.value.length,
                itemBuilder: (context, index) {
                  final todo = todoController.todos.value[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      onTap: () {
                        Get.to(() => EditTodoScreen(oldTodo: todo));
                      },
                      leading: Checkbox(
                        value: todo.isDone,
                        onChanged: (value) {
                          todoController.updateTodoStatus(todo.id, value!);
                        },
                      ),
                      title: Text(
                        todo.title,
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
                          todoController.deleteTodo(todo.id);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CreateTodoScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
