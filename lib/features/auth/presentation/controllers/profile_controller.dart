

import 'package:auth_app1/features/auth/data/models/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController instance = Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var userProfile = Rx<UserProfile?>(null);

  @override
  void onReady() {
    super.onReady();
    _loadUserProfile();
  }

  // Load the user's profile from Firestore
void _loadUserProfile() async {
  User? currentUser = auth.currentUser;
  if (currentUser != null) {
    // Fetch the document from Firestore
    DocumentSnapshot userDoc = await firestore.collection('profiles').doc(currentUser.uid).get();

    // Check if the document exists
    if (userDoc.exists) {
      // Extract data from the DocumentSnapshot and convert it into UserProfile
      Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;

      // Pass the extracted data to the fromMap method
      userProfile.value = UserProfile.fromMap(data, userDoc.id);
    }
  }
}


  // Create or update a user's profile in Firestore
  Future<void> saveProfile(String name, String bio, String profilePictureUrl) async {
    try {
      User? currentUser = auth.currentUser;
      if (currentUser != null) {
        userProfile.value = UserProfile(
          id: currentUser.uid,
          name: name,
          bio: bio,
          profilePictureUrl: profilePictureUrl,
        );

        await firestore.collection('profiles').doc(currentUser.uid).set({
          'name': name,
          'bio': bio,
          'profilePictureUrl': profilePictureUrl,
        });

        Get.snackbar("Success", "Profile saved successfully!",
            backgroundColor: Colors.green, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to save profile: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Read the user's profile
  UserProfile? getUserProfile() {
    return userProfile.value;
  }

  // Update the user's profile in Firestore
  Future<void> updateProfile(String name, String bio, String profilePictureUrl) async {
    try {
      User? currentUser = auth.currentUser;
      if (currentUser != null) {
        await firestore.collection('profiles').doc(currentUser.uid).update({
          'name': name,
          'bio': bio,
          'profilePictureUrl': profilePictureUrl,
        });

        userProfile.value = UserProfile(
          id: currentUser.uid,
          name: name,
          bio: bio,
          profilePictureUrl: profilePictureUrl,
        );

        Get.snackbar("Success", "Profile updated successfully!",
            backgroundColor: Colors.green, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to update profile: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Delete the user's profile
  Future<void> deleteProfile() async {
    try {
      User? currentUser = auth.currentUser;
      if (currentUser != null) {
        await firestore.collection('profiles').doc(currentUser.uid).delete();
        userProfile.value = null;
        Get.snackbar("Success", "Profile deleted successfully!",
            backgroundColor: Colors.green, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to delete profile: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}

