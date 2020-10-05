import 'package:flutter/material.dart';

final ThemeData CompanyThemeData = new ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.red,
    primaryColor: CompanyColors.red[50],
    primaryColorBrightness: Brightness.light,
    accentColor: CompanyColors.yellow[50],
    accentColorBrightness: Brightness.light);

class CompanyColors {
  CompanyColors._(); // this basically makes it so you can instantiate this class
  static const Map<int, Color> red = const <int, Color>{
    50: const Color(0xFFC50C03), //main red
    100: const Color(0xFFA50A03), //background or shadow, darker red
    // 200: const Color(/* some hex code */),
    // 300: const Color(/* some hex code */),
    // 400: const Color(/* some hex code */),
    // 500: const Color(/* some hex code */),
    // 600: const Color(/* some hex code */),
    // 700: const Color(/* some hex code */),
    // 800: const Color(/* some hex code */),
    // 900: const Color(/* some hex code */)
  };

  static const Map<int, Color> yellow = const <int, Color>{
    50: const Color(0xFFfff51c), //main yellow
    // 100: const Color(/* some hex code */),
    // 200: const Color(/* some hex code */),
    // 300: const Color(/* some hex code */),
    // 400: const Color(/* some hex code */),
    // 500: const Color(/* some hex code */),
    // 600: const Color(/* some hex code */),
    // 700: const Color(/* some hex code */),
    // 800: const Color(/* some hex code */),
    // 900: const Color(/* some hex code */)
  };
}
