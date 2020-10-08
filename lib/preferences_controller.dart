import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class PreferencesController {

  static Future<String> getHeroName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('hero_name') ?? "";
  }

  static Future<bool> setHeroName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    print("Saving $name");
    prefs.setString('hero_name', name).then((bool success) {
      return true;
    });
    return false;
  }
}