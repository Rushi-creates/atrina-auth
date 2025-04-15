import 'package:auth_app1/features/auth/data/models/profile.dart';
import 'package:auth_app1/features/auth/data/models/todo.dart';
import 'package:auth_app1/features/auth/domain/repos.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class TodoController extends GetxController {
  // final String userId;
  //  TodoController({required this.userId});

  static TodoController instance = Get.find();

  final String _boxName = 'todos';
  late Box<Todo> _todoBox;

  var todos = Rx<List<Todo>>([]);
  var tempTodos = Rx<List<Todo>>([]);


  RxInt todoPriority = RxInt(0);
  Rx<DateTime?> todoDeadline = Rx<DateTime?>(DateTime.now());




  int get todoCount => todos.value.length;

  @override
  void onInit() {
    super.onInit();
    initHive();
  }

  Future<void> initHive() async {
    var userProfile = await userProfileSpRepo.getModel();
    _todoBox = await Hive.openBox<Todo>(_boxName + userProfile.name);
    fetchTodos();
  }

  void fetchTodos() {
    final todoList = _todoBox.values.toList();
    todos.value = todoList;
    todos.value.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    update();
  }

  void addTempTodo(String title, String? desc,
  //  int? priority,
  //  String? deadline,
   String? labelList,
    ) async {
    final newTodo = Todo(
      id: const Uuid().v4(),
      title: title,
      description: desc,
      priority: todoPriority.value,
      createdAt: DateTime.now(),
      deadline: todoDeadline.value,
      labelList: labelList,
    );

    final updatedList = List<Todo>.from(tempTodos.value);
    updatedList.add(newTodo);
    tempTodos.value = updatedList;
    
  }

 Future<void> addTodosFromTemp() async {
  try {
    for (var todo in tempTodos.value) {
      await _todoBox.put(todo.id, todo);
    }

    tempTodos.value = [];

    fetchTodos();

    Get.snackbar(
      "Success",
      "All temp todos added successfully!",
      snackPosition: SnackPosition.BOTTOM,
    );
  } catch (e) {
    Get.snackbar(
      "Error",
      "Failed to add todos: $e",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

  // Future<void> addTodo(String title) async {
  //   try {
  //     final newTodo = Todo(
  //       id: const Uuid().v4(),
  //       title: title,
  //       createdAt: DateTime.now(),
  //     );

  //     await _todoBox.put(newTodo.id, newTodo);
  //     fetchTodos();

  //     // Get.snackbar(
  //     //   "Success",
  //     //   "Todo added successfully!",
  //     //   snackPosition: SnackPosition.BOTTOM,
  //     // );
  //   } catch (e) {
  //     Get.snackbar(
  //       "Error",
  //       "Failed to add todo: $e",
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }

  Future<void> updateTodoStatus(String id, bool isDone) async {
    try {
      final todo = _todoBox.get(id);
      if (todo != null) {
        final updatedTodo = todo.copyWith(isDone: isDone);
        await _todoBox.put(id, updatedTodo);
        fetchTodos();
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update status: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> updateWholeTodo(Todo oldTodo, Todo newTodo) async {
    try {
      bool hasChanges = false;

      if (oldTodo.title != newTodo.title) hasChanges = true;
      if (oldTodo.isDone != newTodo.isDone) hasChanges = true;

      if (hasChanges) {
        await _todoBox.put(oldTodo.id, newTodo);
        fetchTodos();
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update Todo: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void removeTempTodo(int index) async {
    final updatedList = List<Todo>.from(tempTodos.value);
    updatedList.removeAt(index);
    tempTodos.value = updatedList;
  }

  void removeAllTempTodo() async {
    tempTodos.value = [];
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _todoBox.delete(id);
      fetchTodos();

      Get.snackbar(
        "Success",
        "Todo deleted successfully!",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to delete todo: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> deleteCompletedTodos() async {
    try {
      final completedTodos =
          _todoBox.values.where((todo) => todo.isDone).toList();

      if (completedTodos.isEmpty) return;

      for (var todo in completedTodos) {
        await _todoBox.delete(todo.id);
      }

      fetchTodos();

      Get.snackbar(
        "Success",
        "Completed todos deleted successfully!",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to delete completed todos: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
