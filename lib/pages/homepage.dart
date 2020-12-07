import 'package:flutter/material.dart';
import '../buttons/swipe_button.dart';
import 'package:one_punch_man_workout/preferences_controller.dart';
import 'package:one_punch_man_workout/size_config.dart';
import 'custom_assets/custom_barless_scaffold.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:one_punch_man_workout/app-settings/ranks_definition.dart';
import 'package:one_punch_man_workout/repository/exercise_made_repository.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool exercisedToday =  true;


  Future<bool> checkExercisedToday () async {
    DateTime dtNow = DateTime.now();
    DateTime dtToday = DateTime(dtNow.year, dtNow.month, dtNow.day);
    final List exercises = await ExerciseMadeRepository().getAllExercisesMade(query: [dtToday, dtToday]);
    if(exercises.isNotEmpty) this.exercisedToday = true;
    else this.exercisedToday = true;
    this.setState(() {
      
    });
  }

  @override
  void initState() {
    checkExercisedToday();
  }

  @override
  Widget build(BuildContext context) {
    PlayerRank.getPlayerRankClass();
    SizeConfig().init(context);
    return FutureBuilder(
        future: PreferencesController.getHeroName(),
        builder: (context, snapshot) {
          final heroName = snapshot.data;
          return CustomBarlessScaffold(children: [
            Center(
                child: Text(AppLocalizations.of(context).welcomeBack + ', $heroName !',
                style: TextStyle(
                fontFamily: 'Mangat',
                color: Theme.of(context).primaryColor,
                fontSize: SizeConfig.blockSizeHorizontal * 5,
              ),
            )),
            Image.asset(
              'assets/images/mainpage-bw.png',
              height: SizeConfig.blockSizeVertical * 50,
              width: SizeConfig.blockSizeHorizontal * 30,
            ),
            this.exercisedToday ? Container(
              alignment: Alignment.center,
              child: Text(AppLocalizations.of(context).alreadyTrainedNotice),
            ) : Container(
              height: 100.0,
              width: 100.0,
              child: SwipingButton(
                text: AppLocalizations.of(context).swipeRight + "!",
                onSwipeCallback: () {
                    this.setState(() {
                      
                    });
                    Navigator.of(context).pushNamed('/exercise/register');
                }
              )),
          ]);
        });
  }
}
