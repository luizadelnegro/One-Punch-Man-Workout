import 'package:flutter/material.dart';
import 'pages/homepage.dart';
import 'pages/errorpage.dart';
import 'pages/registerexercise.dart';
import 'pages/heroranking.dart';
import 'pages/agendapage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/exercise/register':
        return MaterialPageRoute(builder: (_) => RegisterExercise());
      case '/ranking':
        return MaterialPageRoute(builder: (_) => HeroRanking());
      case '/progress':
        return MaterialPageRoute(builder: (_) => AgendaPage());
      default:
        return MaterialPageRoute(
            builder: (_) => ErrorPage(errormsg: "Invalid Route!"));
    }
  }
}
