import 'package:auth_app1/core/network/firebase_paths.dart';
import 'package:auth_app1/features/auth/data/models/profile.dart';
import 'package:auth_app1/features/auth/domain/repos.dart';
import 'package:auth_app1/features/auth/domain/utils/common_functions.dart';
import 'package:auth_app1/features/auth/domain/utils/common_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Rx<UserProfile?> userProfile = Rx<UserProfile?>(null);
  
  TextEditingController  emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> registerWithPhone(
    // String number, String password
    ) async {
    try {
      var userDoc =
          await FirebasePaths.numberProfiles
              .where('number', isEqualTo: emailController.text)
              .get();

      if (userDoc.docs.isNotEmpty) {
        Get.snackbar(
          "Account Exists",
          "An account with this number already exists. Please log in.",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      Map<String, dynamic> userMap = {'number': emailController.text, 'password': passwordController.text};

      UserProfile userProfile = UserProfile(
        id: emailController.text,
        name: emailController.text,
        bio: passwordController.text,
        profilePictureUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkoKnnYEns44I5HqlyDuoHdesuKqwLV9dRk28IqUbguJudG7-eAQKYacIzUJEgwNQoLD5Y&s',
      );

      await FirebasePaths.numberProfiles.doc(emailController.text).set(userMap);
      await userProfileSpRepo.set(userProfile);
      await setInitialScreen();

      Get.snackbar(
        "Success",
        "Account created successfully!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      showErrorSnackbar(e.toString());
    }
  }

  Future<void> loginWithPhone(
    // String number, String password
    ) async {
    try {
      var userDocs =
          await FirebasePaths.numberProfiles
              .where('number', isEqualTo: emailController.text)
              .get();

      if (userDocs.docs.isNotEmpty) {
        Map<String, dynamic> userData =
            userDocs.docs.first.data() as Map<String, dynamic>;

        if (userData['password'] == passwordController.text) {
          UserProfile userProfile = UserProfile(
            id: userDocs.docs.first.id,
            name: emailController.text,
            bio: passwordController.text,
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
    // String name,
    // String bio,
    String profilePictureUrl,
  ) async {
    try {
      UserProfile? userSpProfile = await userProfileSpRepo.getModel();

      if (userSpProfile != null) {
        userProfile.value = UserProfile(
          id: userSpProfile.id,
          name: emailController.text,
          bio: passwordController.text,
          profilePictureUrl: profilePictureUrl,
        );

        await FirebasePaths.profiles.doc(userSpProfile.id).set({
          'name': emailController.text,
          'bio': passwordController.text,
          'profilePictureUrl': profilePictureUrl,
        });
      }
    } catch (e) {
      showErrorSnackbar("Failed to save profile: $e");
    }
  }
}
