
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showErrorSnackbar(String errorMessage){
  Get.snackbar(
        "Error",
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
}