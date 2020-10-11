import 'package:flutter/material.dart';
import 'custom_assets/custom_scaffold.dart';
import '../buttons/swipe_button.dart';
import 'package:one_punch_man_workout/preferences_controller.dart';
import 'package:one_punch_man_workout/size_config.dart';
import 'package:one_punch_man_workout/drawer.dart';
import 'custom_assets/custom_barless_scaffold.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return FutureBuilder(
        future: PreferencesController.getHeroName(),
        builder: (context, snapshot) {
          final heroName = snapshot.data;
          return CustomBarlessScaffold(children: [
            Center(
                child: Text(
              "Welcome back, $heroName !",
              style: TextStyle(
                fontFamily: 'Mangat',
                color: Theme.of(context).primaryColor,
                fontSize: SizeConfig.blockSizeHorizontal * 5,
              ),
            )),
            Image.asset(
              'assets/images/saitama_pose.png',
              height: SizeConfig.blockSizeVertical * 50,
              width: SizeConfig.blockSizeHorizontal * 30,
            ),
            RaisedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed('/exercise/register'),
              child: Text("Register your exercise!"),
            ),
            Container(
              height: 100.0,
              width: 100.0,
              child: SwipingButton(
                text: "Swipe to exercise!",
                onSwipeCallback: () =>
                    Navigator.of(context).pushNamed('/exercise/register'),
              ),
            ),
          ]);
        });
  }
}
