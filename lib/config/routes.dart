
import 'package:auth_app1/features/auth/presentation/screens/phone_login_screen.dart';
import 'package:get/get.dart';

/// On Boarding
const String loginView = "login-view";

List<GetPage> routes = [
  // GetPage(
  //   name: '/$splashView',
  //   page: () => const SplashView(),
  //   binding: SplashBinding(),
  // ),
  GetPage(
    name: '/$loginView',
    page: () => const PhoneLoginScreen(),
    // binding: LoginBinding(),
  ),
 
  
];

