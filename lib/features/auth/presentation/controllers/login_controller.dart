import 'package:auth_app1/core/network/firebase_paths.dart';
import 'package:auth_app1/features/auth/data/models/profile.dart';
import 'package:auth_app1/features/auth/domain/repos.dart';
import 'package:auth_app1/features/auth/domain/utils/common_functions.dart';
import 'package:auth_app1/features/auth/domain/utils/common_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  Rx<UserProfile?> userProfile = Rx<UserProfile?>(null);

  Future<void> loginWithPhone(String number, String password) async {
    try {
      var userDocs =
          await FirebasePaths.numberProfiles.where('number', isEqualTo: number).get();

      if (userDocs.docs.isNotEmpty) {
        Map<String, dynamic> userData = userDocs.docs.first.data() as Map<String, dynamic> ;

        if (userData['password'] == password) {
          UserProfile userProfile = UserProfile(
            id: userDocs.docs.first.id, 
            name: number,
            bio: password,
            profilePictureUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkoKnnYEns44I5HqlyDuoHdesuKqwLV9dRk28IqUbguJudG7-eAQKYacIzUJEgwNQoLD5Y&s',
          );

          await userProfileSpRepo.set(userProfile);
          await setInitialScreen();
        } else {
          showErrorSnackbar("Incorrect password");
        }
      } else {
        showErrorSnackbar("User does not exist");
      }
    } catch (e) {
      showErrorSnackbar(e.toString());
    }
  }

   Future<void> saveProfile(
    String name,
    String bio,
    String profilePictureUrl,
  ) async {
    try {
      UserProfile? userSpProfile =
          await userProfileSpRepo.getModel();

      if (userSpProfile != null) {
        userProfile.value = UserProfile(
          id: userSpProfile.id,
          name: name,
          bio: bio,
          profilePictureUrl: profilePictureUrl,
        );

        await FirebasePaths.profiles.doc(userSpProfile.id).set({
          'name': name,
          'bio': bio,
          'profilePictureUrl': profilePictureUrl,
        });
      }
    } catch (e) {
      showErrorSnackbar("Failed to save profile: $e");
    }
  }
}
