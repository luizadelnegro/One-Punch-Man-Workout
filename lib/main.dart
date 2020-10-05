import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'route_generator.dart';
import 'theme.dart' as Theme;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      color: Theme.CompanyColors.red[50],
      theme: Theme.CompanyThemeData,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
