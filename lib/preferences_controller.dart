import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class PreferencesController {

  static Future<void> deleteSharedPreferences() async {
    // For debugging
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

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
    return int.parse(prefs.getString('hero_xp') ?? "0");
  }

  static Future<bool> setHeroXp(int xp) async {
    final String xpStr = xp.toString();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('hero_xp', xpStr).then((bool success) {
      return true;
    });
    return false;
  }

  static Future<String> getPlayerPicturePath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('pic_path');
  }

  static Future<bool> setPlayerPicturePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('pic_path', path).then((bool success) {
      return true;
    });
    return false;
  }
}