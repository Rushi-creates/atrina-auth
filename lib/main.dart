import 'package:auth_app1/features/auth/domain/shared_preference_helper.dart';
import 'package:auth_app1/features/auth/presentation/controllers/auth_controller.dart';
import 'package:auth_app1/features/auth/presentation/controllers/profile_controller.dart';
import 'package:auth_app1/features/auth/presentation/screens/login_screen.dart';
import 'package:auth_app1/features/auth/presentation/screens/phone_login_screen.dart';
import 'package:auth_app1/features/auth/presentation/screens/register_screen.dart';
import 'package:auth_app1/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await SharedPreferencesHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  Get.put(AuthController());
  Get.put(ProfileController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: PhoneLoginScreen(),
      );
  }
}
