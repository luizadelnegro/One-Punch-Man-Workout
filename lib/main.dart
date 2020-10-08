import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:one_punch_man_workout/welcomescreen.dart';
import 'pages/homepage.dart';
import 'package:one_punch_man_workout/preferences_controller.dart';
import 'theme.dart';
import 'route_generator.dart';
import 'package:one_punch_man_workout/size_config.dart';

void main() {
  runApp(MyApp());
}

class MyMaterialApp extends StatelessWidget {
  MyMaterialApp({this.title, this.initialRoute});
  final title;
  final initialRoute;

  Widget build(BuildContext context){
    return MaterialApp( 
      title: this.title,
      color: Theme.of(context).primaryColor,
      theme: DarkPallette,
      initialRoute: this.initialRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
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
            return MyMaterialApp(title: "Welcome back", initialRoute: "/ranking");
          }
          if(snapshot.data == "") {
            // The user has not "registered" yet
            return MyMaterialApp(title: "Welcome", initialRoute: "/welcome");
          }
          else {
            // The user has "registered"
            return MyMaterialApp(title: "Welcome back", initialRoute: "/");
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
