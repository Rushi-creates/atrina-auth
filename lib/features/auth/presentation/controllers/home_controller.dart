

import 'package:auth_app1/features/auth/presentation/controllers/auth_controller.dart';
import 'package:auth_app1/features/auth/presentation/controllers/profile_controller.dart';
import 'package:auth_app1/features/auth/presentation/controllers/todo_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final TodoController todoController = Get.put(TodoController());
  final AuthController authController = Get.find();
  final ProfileController profileController = Get.find();

  
}