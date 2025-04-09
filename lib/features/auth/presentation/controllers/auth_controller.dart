import 'package:auth_app1/features/auth/data/models/profile.dart';
import 'package:auth_app1/features/auth/domain/repos.dart';
import 'package:auth_app1/features/auth/domain/shared_preference_helper.dart';
import 'package:auth_app1/features/auth/domain/utils/common_functions.dart';
import 'package:auth_app1/features/auth/domain/utils/common_widgets.dart';
import 'package:auth_app1/features/auth/presentation/screens/home_screen.dart';
import 'package:auth_app1/features/auth/presentation/screens/login_screen.dart';
import 'package:auth_app1/features/auth/presentation/screens/phone_login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // static AuthController instance = Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var user = Rx<UserProfile?>(null);

  var spUser;

  // @override
  // void onReady() {
  //   super.onReady();
  //   user.bindStream(auth.authStateChanges());
  //   ever(user, _setInitialScreen);
  // }

  @override
  void onReady() {
    super.onReady();
    spUser = setInitialScreen();

    // user.bindStream(auth.authStateChanges());
    // ever(user, _setInitialScreen);
  }

  // setInitialScreen() async {
  //   var spUser = await userProfileSpRepo.get();
  //   if (spUser == null) {
  //     Get.offAll(() => PhoneLoginScreen());
  //   } else {
  //     Get.offAll(() => HomeScreen());
  //   }
  //   return spUser;
  // }

  Future<void> register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar(
        "Success",
        "Account created successfully!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> registerWithPhone(String number, String password) async {
    try {
      // Check if user already exists
      var userDoc =
          await firestore
              .collection('numberProfiles')
              .where('number', isEqualTo: number)
              .get();

      if (userDoc.docs.isNotEmpty) {
        // User already exists, prompt to log in
        Get.snackbar(
          "Account Exists",
          "An account with this number already exists. Please log in.",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      // User doesn't exist, proceed with registration
      Map<String, dynamic> userMap = {'number': number, 'password': password};

      UserProfile userProfile = UserProfile(
        id: number,
        name: number,
        bio: password,
        profilePictureUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkoKnnYEns44I5HqlyDuoHdesuKqwLV9dRk28IqUbguJudG7-eAQKYacIzUJEgwNQoLD5Y&s',
      );

      await firestore.collection('numberProfiles').doc(number).set(userMap);
      await userProfileSpRepo.set(userProfile);
      await setInitialScreen();

      Get.snackbar(
        "Success",
        "Account created successfully!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Future<void> login(String email, String password) async {
  //   try {
  //     await auth.signInWithEmailAndPassword(email: email, password: password);
  //   } catch (e) {
  //     showErrorSnackbar(e.toString());
  //   }
  // }

  Future<void> loginWithPhone(String number, String password) async {
    try {
      // Reference to the Firestore collection
      var userDoc =
          await firestore
              .collection('numberProfiles')
              .where('number', isEqualTo: number)
              .get();

      // Check if user exists
      if (userDoc.docs.isNotEmpty) {
        // User exists, proceed with authentication
        Map<String, dynamic> userData = userDoc.docs.first.data();

        if (userData['password'] == password) {
          UserProfile userProfile = UserProfile(
            id: userDoc.docs.first.id, // Assign document ID
            name: number,
            bio: password,
            profilePictureUrl:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkoKnnYEns44I5HqlyDuoHdesuKqwLV9dRk28IqUbguJudG7-eAQKYacIzUJEgwNQoLD5Y&s',
          );

          await userProfileSpRepo.set(userProfile);
          await setInitialScreen();
        } else {
          Get.snackbar(
            "Error",
            "Incorrect password",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "User does not exist",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
