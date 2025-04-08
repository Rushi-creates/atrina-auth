// // lib/controllers/todo_controller.dart
// import 'package:auth_app1/features/auth/data/models/todo.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class TodoController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   var todos = <Todo>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchTodos();
//   }

//   void fetchTodos() {
//     _firestore.collection('todos').snapshots().listen((snapshot) {
//       todos.value = snapshot.docs
//           .map((doc) => Todo.fromMap(doc.data(), doc.id))
//           .toList();
//     });
//   }

//   Future<void> addTodo(String title) async {
//     await _firestore.collection('todos').add({
//       'title': title,
//       'isDone': false,
//     });
//   }

//   Future<void> updateTodoStatus(String id, bool isDone) async {
//     await _firestore.collection('todos').doc(id).update({'isDone': isDone});
//   }

//   Future<void> deleteTodo(String id) async {
//     await _firestore.collection('todos').doc(id).delete();
//   }
// }

import 'package:auth_app1/features/auth/data/models/profile.dart';
import 'package:auth_app1/features/auth/data/models/todo.dart';
import 'package:auth_app1/features/auth/domain/repos.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoFirebaseController extends GetxController {
  static TodoFirebaseController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var todos = Rx<List<Todo>>([]);

  int get todoCount => todos.value.length;

  @override
  void onReady() {
    super.onReady();
    fetchTodos();
  }

  void fetchTodos() async {
    // User? currentUser = _auth.currentUser;
    UserProfile? userSpProfile = await userProfileSpRepo.getModel();

    if (userSpProfile != null) {
      _firestore
          .collection('todos')
          .where('userId', isEqualTo: userSpProfile.id)
          .snapshots()
          .listen((snapshot) {
            todos.value =
                snapshot.docs.map((doc) {
                  return Todo.fromMap(doc.data(),
                   doc.id);
                }).toList();
          });
    }
  }

  // Add a new todo
  Future<void> addTodo(String title) async {
    try {
      // User? currentUser = _auth.currentUser;
      UserProfile? userSpProfile = await userProfileSpRepo.getModel();

      if (userSpProfile != null) {
        await _firestore.collection('todos').add({
          'title': title,
          'isDone': false,
          'userId': userSpProfile.id,
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Get.snackbar(
        //   "Success",
        //   "Todo added successfully!",
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        // );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to add todo: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Update todo status
  Future<void> updateTodoStatus(String id, bool isDone) async {
    try {
      await _firestore.collection('todos').doc(id).update({'isDone': isDone});

      // Get.snackbar(
      //   "Success",
      //   "Todo status updated!",
      //   backgroundColor: Colors.green,
      //   colorText: Colors.white,
      // );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update status: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Update todo status
  // Future<void> updateWholeTodo(String oldTodoId, Todo newTodo) async {
  //   try {
  //     await _firestore.collection('todos').doc(oldTodoId).update({'isDone': newTodo.isDone ,
  //     });

  //     Get.snackbar("Success", "Todo status updated!",
  //         backgroundColor: Colors.green, colorText: Colors.white);
  //   } catch (e) {
  //     Get.snackbar("Error", "Failed to update status: $e",
  //         backgroundColor: Colors.red, colorText: Colors.white);
  //   }
  // }

  Future<void> updateWholeTodo(Todo oldTodo, Todo newTodo) async {
    try {
      // Prepare a map for the updated fields
      Map<String, dynamic> updatedFields = {};

      // Check each field to see if it has changed
      if (oldTodo.title != newTodo.title) {
        updatedFields['title'] = newTodo.title;
      }
      if (oldTodo.isDone != newTodo.isDone) {
        updatedFields['isDone'] = newTodo.isDone;
      }
      if (oldTodo.createdAt != newTodo.createdAt) {
        updatedFields['createdAt'] = Timestamp.fromDate(newTodo.createdAt);
      }

      // If there are any updated fields, perform the update
      if (updatedFields.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('todos')
            .doc(oldTodo.id)
            .update(updatedFields);

        // Show success message
        // Get.snackbar(
        //   "Success",
        //   "Todo updated successfully!",
        //   backgroundColor: Colors.green,
        //   colorText: Colors.white,
        // );
      } else {
        // If no fields were updated
        // Get.snackbar(
        //   "No Changes",
        //   "No changes were made to the Todo.",
        //   backgroundColor: Colors.yellow,
        //   colorText: Colors.black,
        // );
      }
    } catch (e) {
      // Handle errors and show failure message
      Get.snackbar(
        "Error",
        "Failed to update Todo: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Delete a todo
  Future<void> deleteTodo(String id) async {
    try {
      await _firestore.collection('todos').doc(id).delete();

      // Get.snackbar(
      //   "Success",
      //   "Todo deleted successfully!",
      //   backgroundColor: Colors.green,
      //   colorText: Colors.white,
      // );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to delete todo: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
