import 'package:auth_app1/features/auth/presentation/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneRegisterScreen extends GetView<RegisterController> {
  const PhoneRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register with Phone number")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() => TextFormField(
              controller: controller.emailController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Number",
                errorText: controller.phoneError.value.isEmpty ? null : controller.phoneError.value,
              ),
              onChanged: (value) => controller.validatePhone(value),
            )),
            
            const SizedBox(height: 16),
            
            Obx(() => TextFormField(
              controller: controller.passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                errorText: controller.passwordError.value.isEmpty ? null : controller.passwordError.value,
              ),
              obscureText: true,
              onChanged: (value) => controller.validatePassword(value),
            )),
          
            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () async {
                
                if (controller.validateForm()) {
                await controller.registerWithPhone();
                // if (controller.phoneError.value.isEmpty && controller.passwordError.value.isEmpty) {
                  await controller.saveProfile(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSEriWalt3rgigUMC63Bhg4viP_gHy3dHBidlLGVY2ds5rcQO90qjHgXs&s',
                  );
                }
              },
              child: const Text("Register"),
            ),
            
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}