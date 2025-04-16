import 'package:auth_app1/config/routes.dart';
import 'package:auth_app1/features/auth/data/models/profile.dart';
import 'package:auth_app1/features/auth/domain/repos.dart';
import 'package:auth_app1/features/auth/presentation/controllers/home_controller.dart';
import 'package:auth_app1/features/auth/presentation/controllers/todo_controller.dart';
import 'package:get/get.dart';

setInitialScreen() async {
  UserProfile? spUser = await userProfileSpRepo.getModel();
  TodoController todoController = Get.find<TodoController>();

  todoController.initHive();

  print('-----------> $spUser');

  if (spUser == null) {
    Get.offAllNamed(loginView);
  } else {
    Get.offAllNamed(homeView);
  }
  return spUser;
}

//   if (spUser == null) {
//     Get.offAllNamed(loginView);
//   } else {
//     if (Get.isRegistered<HomeController>()) {
//       Get.delete<HomeController>();
//     }
//     Get.offAllNamed(homeView);
//   }
//   return spUser;
// }
