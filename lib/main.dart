// import 'package:auth_app1/features/auth/domain/repos.dart';
// import 'package:auth_app1/features/auth/domain/shared_preference_helper.dart';
// import 'package:auth_app1/features/auth/presentation/controllers/auth_controller.dart';
// import 'package:auth_app1/features/auth/presentation/controllers/profile_controller.dart';
// import 'package:auth_app1/features/auth/presentation/screens/login_screen.dart';
// import 'package:auth_app1/features/auth/presentation/screens/phone_login_screen.dart';
// import 'package:auth_app1/features/auth/presentation/screens/register_screen.dart';
// import 'package:auth_app1/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'features/auth/presentation/screens/profile_screen.dart';

// void main() async {
//     WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//   await SharedPreferencesHelper.init();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
// );
//   // Get.put(AuthController());
//   // Get.put(ProfileController());

//   var store = await userProfileSpRepo.get();
//   print(store);
//   runApp(const MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ProfilePage(),
//       // theme: ThemeData.dark(),
//       themeMode: ThemeMode.system,
//       theme: 
//        ThemeData(
//         primarySwatch: Colors.red,
//         primaryColor: Colors.blue
//         // primaryColorDark: ThemeData.dark()
//         // themeMode : 
//       ),
//       // home: PhoneLoginScreen(),
//       );
//   }
// }



// for AUTH APP
import 'package:auth_app1/features/auth/domain/repos.dart';
import 'package:auth_app1/features/auth/domain/shared_preference_helper.dart';
import 'package:auth_app1/features/auth/presentation/controllers/auth_controller.dart';
import 'package:auth_app1/features/auth/presentation/controllers/profile_controller.dart';
import 'package:auth_app1/features/auth/presentation/controllers/theme_controller.dart';
import 'package:auth_app1/features/auth/presentation/screens/login_screen.dart';
import 'package:auth_app1/features/auth/presentation/screens/phone_login_screen.dart';
import 'package:auth_app1/features/auth/presentation/screens/register_screen.dart';
import 'package:auth_app1/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  
  await GetStorage.init(); 
  await SharedPreferencesHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController());
  Get.put(ProfileController());
   Get.put(ThemeController()); 


  var store = await userProfileSpRepo.get();
  print(store);
  runApp( MainApp());
}

class MainApp extends StatelessWidget {
  // const MainApp({super.key});

    final ThemeController themeController = Get.put(ThemeController());


  @override
  Widget build(BuildContext context) {
    return

    Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeController.themes[themeController.themeIndex],
          home: PhoneLoginScreen(),
        ));
   
  }
}
