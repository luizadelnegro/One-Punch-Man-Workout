import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:one_punch_man_workout/welcomescreen.dart';
import 'pages/homepage.dart';
import 'package:one_punch_man_workout/preferences_controller.dart';
import 'theme.dart';
import 'route_generator.dart';
import 'package:one_punch_man_workout/size_config.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class RegisteredMaterialApp extends StatelessWidget {
  RegisteredMaterialApp({this.title, this.initialRoute});
  final title;
  final initialRoute;

  Widget build(BuildContext context){
    
    return MaterialApp( 
      title: this.title,
      color: Theme.of(context).primaryColor,
      theme: Manga,
      initialRoute: this.initialRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class UnregisteredMaterialAApp extends StatelessWidget {

  Widget build(BuildContext context){
    
    return MaterialApp( 
      title: "Register!",
      color: Theme.of(context).primaryColor,
      theme: Manga,
      home: WelcomeScreen()
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder( 
      future: PreferencesController.getHeroName(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          if(snapshot.hasError){
            // TODO: Check if there is a chance of failure with SharedPreferences
            //    If there is, do a proper error management
            return UnregisteredMaterialAApp();
          }
          if(snapshot.data == "") {
            // The user has not "registered" yet
            return UnregisteredMaterialAApp();
          }
          else {
            // The user has "registered"
            return RegisteredMaterialApp(title: "Welcome back", initialRoute: "/");
          }
        }
        else {
          // Loading
          return CircularProgressIndicator();
        }
      },
    );
  }
}
