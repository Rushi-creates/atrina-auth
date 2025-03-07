import 'package:auth_app1/features/auth/data/models/profile.dart';
import 'package:auth_app1/features/auth/domain/repos.dart';
import 'package:auth_app1/features/auth/domain/shared_preference_helper.dart';
import 'package:auth_app1/features/auth/presentation/screens/home_screen.dart';
import 'package:auth_app1/features/auth/presentation/screens/login_screen.dart';
import 'package:auth_app1/features/auth/presentation/screens/phone_login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  var user = Rx<User?>(null);

  // @override
  // void onReady() {
  //   super.onReady();
  //   user.bindStream(auth.authStateChanges());
  //   ever(user, _setInitialScreen);
  // }

    @override
  void onReady() {
    super.onReady();
    user.bindStream(auth.authStateChanges());
    ever(user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {


    if (user == null) {
      Get.offAll(() => PhoneLoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

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
    Map<String, dynamic> userMap = {'number': number, 'password': password};
    try {
      // await firestore.collection('numberProfiles').doc().set(userMap);
      await userProfileSpRepo.set(userMap);
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

  Future<void> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> loginWithPhone(String number, String password) async {
    Map<String, dynamic> userMap = {'number': number, 'password': password};

    try {
      // await auth.signInWithEmailAndPassword(email: email, password: password);
      await userProfileSpRepo.set(userMap);
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
