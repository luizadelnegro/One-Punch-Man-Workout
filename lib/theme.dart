import 'package:flutter/material.dart';

final ThemeData DefaultPalette = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.red,
  primaryColor: Color(0xFFC50C03),
  primaryColorBrightness: Brightness.light,
  backgroundColor: Color(0xFFA50A03),
  accentColor: Color(0xFFfff51c),
  accentColorBrightness: Brightness.light
);

final ThemeData DarkPallette = new ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.red,
  primaryColor: Color.fromARGB(140, 255, 0, 0),
  primaryColorBrightness: Brightness.dark,
  backgroundColor: Color.fromARGB(70, 255, 0, 0),
  accentColor: Color.fromARGB(150, 255, 255, 0),
  accentColorBrightness: Brightness.dark
);