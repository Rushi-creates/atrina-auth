import 'package:flutter/material.dart';

class SignInWithPhoneWidget extends StatelessWidget {
  final Function() onTap;
  const SignInWithPhoneWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Text('Sign in with Phone'));
  }
}
