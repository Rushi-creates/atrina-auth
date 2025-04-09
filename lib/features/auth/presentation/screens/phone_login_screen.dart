import 'package:auth_app1/features/auth/presentation/controllers/auth_controller.dart';
import 'package:auth_app1/features/auth/presentation/controllers/login_controller.dart';
import 'package:auth_app1/features/auth/presentation/controllers/profile_controller.dart';
import 'package:auth_app1/features/auth/presentation/screens/phone_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'register_screen.dart';

class PhoneLoginScreen extends GetView<LoginController> {
  const PhoneLoginScreen({super.key});


  @override
  Widget build(BuildContext context) {
//     return Text('hey');
//   }
// }



// class PhoneLoginScreen extends StatelessWidget {
  final TextEditingController  emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
//   final AuthController authController = Get.find();
//   final ProfileController profileController = Get.find();

//   @override
//   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login with Phone number")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.number, // Allows only numbers
              decoration: InputDecoration(labelText: "Number"),
              // validator 
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await controller.loginWithPhone(
                  emailController.text,
                  passwordController.text,
                );

                await controller.saveProfile(
                  emailController.text,
                  passwordController.text,
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSEriWalt3rgigUMC63Bhg4viP_gHy3dHBidlLGVY2ds5rcQO90qjHgXs&s',
                );
              },
              child: Text("Login"),
            ),
            TextButton(
              onPressed: () {
                Get.to(() => PhoneRegisterScreen());
              },
              child: Text("Don't have an account? Register"),
            ),
          ],
        ),
      ),
    );
  }
}
