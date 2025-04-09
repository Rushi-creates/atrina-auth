// import 'package:auth_app1/features/auth/presentation/controllers/auth_controller.dart';
// import 'package:auth_app1/features/auth/presentation/controllers/profile_controller.dart';
// import 'package:auth_app1/features/auth/presentation/screens/phone_login_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../widgets/sign_in_with_phone_widget.dart';
// import 'register_screen.dart';

// class LoginScreen extends StatelessWidget {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final AuthController authController = Get.find();
//   final ProfileController profileController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Login")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(labelText: "Email"),
//             ),
//             TextField(
//               controller: passwordController,
//               decoration: InputDecoration(labelText: "Password"),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 await authController.login(
//                   emailController.text,
//                   passwordController.text,
//                 );

//                 // await profileController.saveProfile(
//                 //   emailController.text,
//                 //   emailController.text,
//                 //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSEriWalt3rgigUMC63Bhg4viP_gHy3dHBidlLGVY2ds5rcQO90qjHgXs&s',
//                 // );
//               },
//               child: Text("Login"),
//             ),
//             TextButton(
//               onPressed: () {
//                 Get.to(() => RegisterScreen());
//               },
//               child: Text("Don't have an account? Register"),
//             ),

//             //
//             SignInWithPhoneWidget(onTap: () => Get.to(PhoneLoginScreen())),
//           ],
//         ),
//       ),
//     );
//   }
// }
