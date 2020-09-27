import 'package:flutter/material.dart';
import 'assets/custom_scaffold.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    
    return CustomScaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("Home Page"),
            RaisedButton(
              onPressed: () => Navigator.of(context).pushNamed('/exercise/register'),
              child: Text("Register your exercise!"),
            )
          ],
        ),
      ),
      title: "Home",
    );
  }
}
