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
import 'package:auth_app1/config/flavor_config.dart';
import 'package:auth_app1/core/utils/device_information.dart';
import 'package:auth_app1/features/auth/data/models/todo.dart';
import 'package:auth_app1/features/auth/domain/repos.dart';
import 'package:auth_app1/features/auth/domain/shared_preference_helper.dart';
import 'package:auth_app1/features/auth/presentation/controllers/auth_controller.dart';
import 'package:auth_app1/features/auth/presentation/controllers/home_controller.dart';
import 'package:auth_app1/features/auth/presentation/controllers/login_controller.dart';
import 'package:auth_app1/features/auth/presentation/controllers/post_controller.dart';
import 'package:auth_app1/features/auth/presentation/controllers/profile_controller.dart';
import 'package:auth_app1/features/auth/presentation/controllers/register_controller.dart';
import 'package:auth_app1/features/auth/presentation/controllers/theme_controller.dart';
import 'package:auth_app1/features/auth/presentation/screens/login_screen.dart';
import 'package:auth_app1/features/auth/presentation/screens/phone_login_screen.dart';
import 'package:auth_app1/features/auth/presentation/screens/register_screen.dart';
import 'package:auth_app1/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  /// Config the flavor
  String packageName = await DeviceInformation().getAppPackageName();
  if (packageName.contains('prod')) {
    FlavorConfig(flavor: Flavor.prod);
  } else if (packageName.contains('stage')) {
    FlavorConfig(flavor: Flavor.stage);
  } else if (packageName.contains('qa')) {
    FlavorConfig(flavor: Flavor.qa);
  } else {
    FlavorConfig(flavor: Flavor.dev);
  }

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  Hive.registerAdapter(TodoAdapter());

  await GetStorage.init();
  await SharedPreferencesHelper.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController());
  Get.put(LoginController());
  Get.put(RegisterController());
  Get.put(ProfileController());
  Get.put(HomeController());
  Get.put(ThemeController());
  Get.put(PostController());

  var store = await userProfileSpRepo.get();
  print(store);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  // const MainApp({super.key});

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeController.themes[themeController.themeIndex],
        home: PhoneLoginScreen(),
      ),
    );
  }
}

// import 'package:auth_app1/features/auth/presentation/bindings/country_binding.dart';
// import 'package:auth_app1/features/auth/presentation/screens/country_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';

// void main() async {
//   await initHiveForFlutter();

//   final HttpLink httpLink = HttpLink('https://countries.trevorblades.com/');

//   ValueNotifier<GraphQLClient> client = ValueNotifier(
//     GraphQLClient(
//       link: httpLink,
//       cache: GraphQLCache(store: HiveStore()),
//     ),
//   );

//   runApp(
//     GraphQLProvider(
//       client: client,
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp();

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialBinding: CountryBinding(),
//       home: CountryView(),
//     );
//   }
// }
