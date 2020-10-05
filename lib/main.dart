import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'route_generator.dart';
import 'theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      color: Theme.of(context).primaryColor,
      theme: DefaultPalette,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
