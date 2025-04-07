import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _themeIndex = 0.obs; // 0 = Light, 1 = Dark, 2 = Blue, 3 = Green

  int get themeIndex => _themeIndex.value;


//
  final List<ThemeData> themes = [
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blue,
    ),
    ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.deepPurple,
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.blueGrey,
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.green,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    _themeIndex.value = _box.read('themeIndex') ?? 0;
    Future.delayed(Duration.zero, () {
      Get.changeTheme(themes[_themeIndex.value]);
    });
  }

  void switchTheme(int index) {
    _themeIndex.value = index;
    Get.changeTheme(themes[index]);
    _box.write('themeIndex', index);
  }
}
