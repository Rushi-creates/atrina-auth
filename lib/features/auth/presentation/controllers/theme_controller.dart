import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _themeIndex = 0.obs; // 0 = Light, 1 = Dark, 2 = Blue, 3 = Green

  int get themeIndex => _themeIndex.value;

  //
  final List<ThemeData> themes = [
    ThemeData(brightness: Brightness.light, primarySwatch: Colors.blue),
    ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.deepPurple,
      primaryTextTheme: TextTheme(),
      // textTheme: TextTheme(titleSmall: TextStyle(color: Colors.white))
    ),
    ThemeData(
      brightness: Brightness.dark,
      primarySwatch: MaterialColor(0xFF212121, <int, Color>{
        50: Color(0xFFFAFAFA),
        100: Color(0xFFF5F5F5),
        200: Color(0xFFEEEEEE),
        300: Color(0xFFE0E0E0),
        400: Color(0xFFBDBDBD),
        500: Color(0xFF9E9E9E),
        600: Color(0xFF616161),
        700: Color(0xFF424242),
        800: Color(0xFF303030),
        900: Color(0xFF212121),
      }),

      cardColor: MaterialColor(0xFF212121, <int, Color>{
        50: Color(0xFFFAFAFA),
        100: Color(0xFFF5F5F5),
        200: Color(0xFFEEEEEE),
        300: Color(0xFFE0E0E0),
        400: Color(0xFFBDBDBD),
        500: Color(0xFF9E9E9E),
        600: Color(0xFF616161),
        700: Color(0xFF424242),
        800: Color(0xFF303030),
        900: Color(0xFF212121),
      }),
      scaffoldBackgroundColor: MaterialColor(0xFF212121, <int, Color>{
        50: Color(0xFFFAFAFA),
        100: Color(0xFFF5F5F5),
        200: Color(0xFFEEEEEE),
        300: Color(0xFFE0E0E0),
        400: Color(0xFFBDBDBD),
        500: Color(0xFF9E9E9E),
        600: Color(0xFF616161),
        700: Color(0xFF424242),
        800: Color(0xFF303030),
        900: Color(0xFF212121),
      }),
    ),
    ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.green,
      cardColor: Colors.greenAccent,
      scaffoldBackgroundColor: Colors.greenAccent,
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
