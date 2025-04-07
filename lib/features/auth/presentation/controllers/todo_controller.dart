
import 'package:auth_app1/features/auth/data/models/todo.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

class TodoController extends GetxController {
  static TodoController instance = Get.find();
  
  final String _boxName = 'todos';
  late Box<Todo> _todoBox;
  
  var todos = Rx<List<Todo>>([]);
  
  int get todoCount => todos.value.length;

  @override
  void onInit() {
    super.onInit();
    _initHive();
  }

  Future<void> _initHive() async {
    _todoBox = await Hive.openBox<Todo>(_boxName);
    fetchTodos();
  }

  void fetchTodos() {
    final todoList = _todoBox.values.toList();
    todos.value = todoList;
    // Sort by creation date (newest first)
    todos.value.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    update();
  }

  // Add a new todo
  Future<void> addTodo(String title) async {
    try {
      final newTodo = Todo(
        id: const Uuid().v4(),
        title: title,
        createdAt: DateTime.now(),
      );
      
      await _todoBox.put(newTodo.id, newTodo);
      fetchTodos();
      
      Get.snackbar(
        "Success",
        "Todo added successfully!",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to add todo: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Update todo status
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
      // Check if anything has changed
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

  // Delete a todo
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
}
