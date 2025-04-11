import 'package:auth_app1/features/auth/presentation/controllers/auth_controller.dart';
import 'package:auth_app1/features/auth/presentation/controllers/profile_controller.dart';
import 'package:auth_app1/features/auth/presentation/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneRegisterScreen extends GetView<RegisterController> {
  const PhoneRegisterScreen({super.key});


  // final AuthController authController = Get.find();
  // final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    
  // final TextEditingController  emailController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Register with Phone number")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.emailController,
              keyboardType: TextInputType.number, 
              decoration: InputDecoration(labelText: "Number"),
            ),
            TextField(
              controller: controller.passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await controller.registerWithPhone(
                  // emailController.text,
                  // passwordController.text,
                );
                await controller.saveProfile(
                  // emailController.text,
                  // passwordController.text,
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
          ],
        ),
      ),
    );
  }
}
