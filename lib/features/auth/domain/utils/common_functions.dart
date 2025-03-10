  import 'package:auth_app1/features/auth/domain/repos.dart';
import 'package:auth_app1/features/auth/presentation/screens/home_screen.dart';
import 'package:auth_app1/features/auth/presentation/screens/phone_login_screen.dart';
import 'package:get/get.dart';

setInitialScreen() async {
  var  spUser = await userProfileSpRepo.get();

  print('-----------> $spUser');

    if (spUser == null) {
      Get.offAll(() => PhoneLoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
    return spUser;
  }