import 'package:auth_app1/features/auth/presentation/controllers/auth_controller.dart';
import 'package:auth_app1/features/auth/presentation/controllers/profile_controller.dart';
import 'package:auth_app1/features/auth/presentation/screens/phone_register_screen.dart';
import 'package:auth_app1/features/auth/presentation/widgets/sign_in_with_phone_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthController authController = Get.find();
  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await authController.register(
                  emailController.text,
                  passwordController.text,
                );
                await profileController.saveProfile(
                  emailController.text,
                  emailController.text,
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSEriWalt3rgigUMC63Bhg4viP_gHy3dHBidlLGVY2ds5rcQO90qjHgXs&s',
                );
              },
              child: Text("Register"),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Already have an account? Login"),
            ),

            //
            SignInWithPhoneWidget(onTap: () => Get.to(PhoneRegisterScreen())),
          ],
        ),
      ),
    );
  }
}
