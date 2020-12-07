import 'package:one_punch_man_workout/preferences_controller.dart';
import 'package:one_punch_man_workout/model/exercise_made_model.dart';
import 'package:one_punch_man_workout/bloc/exercise_made_bloc.dart';


class ClassDefinition {
  final int order;
  final String className;
  final int minXp;
  final int maxXp;

  ClassDefinition(this.order, this.className, this.minXp, this.maxXp);
}

final classesDefinition = [
    new ClassDefinition(
      1,
      "A",
      10000,
      100000
    ),
    new ClassDefinition(
      2,
      "B",
      2000,
      9999
    ),
    new ClassDefinition(
      3,
      "C",
      1,
      1999
    )
];

class PlayerRank {
  static int xp;
  static int rank;
  static ClassDefinition rankClass;

  static Future<void> updatePlayerXp() async {
    PlayerRank.xp = await PreferencesController.getHeroXp();
  }
  static Future<int> getPlayerXP() async {
    if(xp == null){
      await updatePlayerXp();
    }
    return xp;
  }
  static Future<String> getPlayerRankClass() async {
    xp = await getPlayerXP();
    if(rankClass == null){
      for(ClassDefinition classification in classesDefinition) {
        if ( (xp >= classification.minXp) && (xp < classification.maxXp) ) {
          PlayerRank.rankClass = classification;
          return classification.className;

        }
      }
    } else {
      return rankClass.className;
    }
  }
  static Future<int> getPlayerRankNum() async {
    xp = await getPlayerXP();
    await getPlayerRankClass().then((value) => () {
       return (100 - (xp/((rankClass.maxXp - rankClass.minXp)/100))).floor();
    });
    // 100 - xp/((maxXp - minXp)/100)
  }
  static Future<void> addPlayerXp(int addXp) async {
    int oldXp = await getPlayerXP();
    int newXp = oldXp + addXp;
    await PreferencesController.setHeroXp(newXp);
    PlayerRank.xp = newXp;
  }
  static Future<void> registerExercise(ExerciseMade exercise) async {
    double mult = 1;
    if(exercise.completed){
      mult = mult + 1.5;
    }
    ExerciseMadeBloc bloc = ExerciseMadeBloc();
    bloc.getExercisesMade(query: [DateTime.now().subtract(new Duration(days: 15)), DateTime.now()]);
    List<DateTime> last15Days = new List();
    bloc.exercisesMade.listen(
      (data) {
        for(ExerciseMade exercise in data){
          last15Days.add(exercise.dtdone);
        }
      },
      () {
        last15Days.sort();
        print("A");
      }
    );
    print("B");

  }


}