import 'package:flutter/material.dart';
import 'custom_assets/custom_scaffold.dart';
import '../buttons/main_button.dart';

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
            Image.asset(
              'assets/images/saitama_pose.png',
              height: 400,
              width: 200,
            ),
            RaisedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed('/exercise/register'),
              child: Text("Register your exercise!"),
            ),
            MainButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed('/exercise/register'),
              child: Text("Register your exercise!",
                  style: TextStyle(color: Colors.black)),
            )
          ],
        ),
      ),
      title: "Home",
    );
  }
}
