  import 'package:auth_app1/config/routes.dart';
import 'package:auth_app1/features/auth/domain/repos.dart';
import 'package:get/get.dart';

setInitialScreen() async {
  var  spUser = await userProfileSpRepo.get();

  print('-----------> $spUser');

    if (spUser == null) {
      Get.offAllNamed(loginView);
    } else {
      Get.offAllNamed(homeView);
    }
    return spUser;
  }