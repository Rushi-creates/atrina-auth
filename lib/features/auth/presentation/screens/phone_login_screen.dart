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
              controller: controller.emailController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Number"),
            ),
            TextField(
              controller: controller.passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            // TextFormField(
            //   controller: emailController,
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(
            //     labelText: "Number",
            //     // errorText: _emailError, // You'll need to define this variable in your state
            //   ),
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Please enter a number';
            //     }
            //     if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
            //       return 'Please enter only numbers';
            //     }
            //     return null; // Return null if validation passes
            //   },
            //   onChanged: (value) {
            //     // Optional: validate on change
            //     // setState(() {
            //     //   _emailError = value.isEmpty ? 'Number is required' :
            //     //                !RegExp(r'^[0-9]+$').hasMatch(value) ? 'Please enter only numbers' : null;
            //     // });
            //   },
            // ),

            // TextFormField(
            //   controller: passwordController,
            //   decoration: InputDecoration(
            //     labelText: "Password",
            //     // errorText: _passwordError, // You'll need to define this variable in your state
            //   ),
            //   obscureText: true,
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Please enter a password';
            //     }
            //     if (value.length < 6) {
            //       return 'Password must be at least 6 characters';
            //     }
            //     return null; // Return null if validation passes
            //   },
            //   // onChanged: (value) {
            //   //   // Optional: validate on change
            //   //   setState(() {
            //   //     _passwordError = value.isEmpty ? 'Password is required' :
            //   //                     value.length < 6 ? 'Password must be at least 6 characters' : null;
            //   //   });
            //   // },
            // ),
          
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await controller.loginWithPhone(
                  // controller.emailController.text,
                  // controller.passwordController.text,
                );

                await controller.saveProfile(
                  // controller.emailController.text,
                  // controller.passwordController.text,
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
