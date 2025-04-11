import 'package:auth_app1/features/auth/presentation/bindings/home_binding.dart';
import 'package:auth_app1/features/auth/presentation/bindings/login_binding.dart';
import 'package:auth_app1/features/auth/presentation/bindings/post_binding.dart';
import 'package:auth_app1/features/auth/presentation/bindings/profile_binding.dart';
import 'package:auth_app1/features/auth/presentation/bindings/register_binding.dart';
import 'package:auth_app1/features/auth/presentation/screens/edit_todo_screen.dart';
import 'package:auth_app1/features/auth/presentation/screens/home_screen.dart';
import 'package:auth_app1/features/auth/presentation/screens/phone_login_screen.dart';
import 'package:auth_app1/features/auth/presentation/screens/phone_register_screen.dart';
import 'package:auth_app1/features/auth/presentation/screens/post_screen.dart';
import 'package:auth_app1/features/auth/presentation/screens/profile_screen_new.dart';
import 'package:get/get.dart';

/// On Boarding
const String loginView = "login-view";
const String registerView = "register-view";
const String homeView = "home-view";
const String postView = "post-view";
const String profileView = "profile-view";
const String editTodoView = "edit-todo-view";

List<GetPage> routes = [
  GetPage(
    name: '/$loginView',
    page: () => const PhoneLoginScreen(),
    binding: LoginBinding(),
  ),

  GetPage(
    name: '/$registerView',
    page: () => const PhoneRegisterScreen(),
    binding: RegisterBinding(),
  ),

  GetPage(
    name: '/$homeView',
    page: () => const HomeScreen(),
    binding: HomeBinding(),
  ),

  GetPage(
    name: '/$postView',
    page: () => const PostView(),
    binding: PostBinding(),
  ),

  GetPage(
    name: '/$profileView',
    page: () => ProfileView(),
    binding: ProfileBinding(),
  ),
  
  // GetPage(
  //   name: '/$editTodoView',
  //   page: () => EditTodoScreen(),
  //   binding: ProfileBinding(),
  // ),
  
  // GetPage(
  //   name: '/$profileView',
  //   page: () => ProfileView(),
  //   binding: ProfileBinding(),
  // ),
];
