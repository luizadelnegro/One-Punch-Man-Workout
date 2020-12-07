import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class PreferencesController {

  static Future<String> getHeroName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('hero_name') ?? "";
  }

  static Future<bool> setHeroName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('hero_name', name).then((bool success) {
      return true;
    });
    return false;
  }

  static Future<int> getHeroXp() async {
    final prefs = await SharedPreferences.getInstance();
    return int.parse(prefs.getString('hero_xp') ?? "-1");
  }

  static Future<bool> setHeroXp(int xp) async {
    final String xpStr = xp.toString();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('hero_xp', xpStr).then((bool success) {
      return true;
    });
    return false;
  }
}