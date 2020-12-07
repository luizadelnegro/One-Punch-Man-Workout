import 'package:flutter/material.dart';
import 'pages/homepage.dart';
import 'pages/errorpage.dart';
import 'pages/registerexercise.dart';
import 'pages/heroranking.dart';
import 'pages/agendapage.dart';
import 'pages/bluetooth.dart';
import 'welcomescreen.dart';
import 'pages/camera.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/welcome':
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case '/exercise/register':
        return MaterialPageRoute(builder: (_) => RegisterExercise());
      case '/ranking':
        return MaterialPageRoute(builder: (_) => HeroRanking());
      case '/progress':
        return MaterialPageRoute(builder: (_) => AgendaPage());
      case '/bluetooth':
        return MaterialPageRoute(builder: (_) => BluetoothApp());
      case '/camera':
        return MaterialPageRoute(builder: (_) => TakePictureScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => ErrorPage(errormsg: "Invalid Route!"));
    }
  }
}
