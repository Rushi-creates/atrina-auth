
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

showGetDialog(Widget content){
  Get.dialog(
    AlertDialog(
      title: const Text("Details"),
      content: content,
      actions: [
        TextButton(
          child: const Text("OK"),
          onPressed: () {
            Get.back();
          },
        ),
        
    ]
  ));
}