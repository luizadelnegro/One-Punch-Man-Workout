import 'dart:async';

import 'package:one_punch_man_workout/preferences_controller.dart';
import 'package:one_punch_man_workout/model/exercise_made_model.dart';
import 'package:one_punch_man_workout/bloc/exercise_made_bloc.dart';
import 'package:one_punch_man_workout/repository/exercise_made_repository.dart';

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
  static String imgPath;
  static Future<void> updatePlayerXp() async {
    PlayerRank.xp = await PreferencesController.getHeroXp();
  }
  static Future<int> getPlayerXP() async {
    if(xp == null){
      await updatePlayerXp();
    }
    return xp;
  }
  static Future<ClassDefinition> getPlayerRankClass() async {
    xp = await getPlayerXP();
    if(rankClass == null){
      for(ClassDefinition classification in classesDefinition) {
        if ( (xp >= classification.minXp) && (xp < classification.maxXp) ) {
          PlayerRank.rankClass = classification;
          return classification;

        }
      }
    } else {
      return rankClass;
    }
  }
  static Future<String> getPlayerImgPath() async {
    if (PlayerRank.imgPath == null){
      PlayerRank.imgPath = await PreferencesController.getPlayerPicturePath();
    }
    return PlayerRank.imgPath;
  }
  static Future<bool> setPlayerImgPath(String path) async {
    bool success = await PreferencesController.setPlayerPicturePath(path);
    await getPlayerImgPath();
    return success;
  }
  
  static Future<int> getXpToNextRank() async {
    int playerRank = await getPlayerRankNum(); 
    int nextRank = playerRank + 1;
    int xp = await getPlayerXP();
    double nextXP = nextRank * ((rankClass.maxXp - rankClass.minXp)/100) - xp;
    return nextXP.ceil();
  }
  static Future<int> getPlayerRankNum() async {
    xp = await getPlayerXP();
    ClassDefinition rankClass = await getPlayerRankClass();
    return (100 - (xp/((rankClass.maxXp - rankClass.minXp)/100))).floor();
  }
  static Future<void> addPlayerXp(int addXp) async {
    int oldXp = await getPlayerXP();
    int newXp = oldXp + addXp;
    await PreferencesController.setHeroXp(newXp);
    PlayerRank.xp = newXp;
  }
  static Future<int> getExerciseStreak() async {
    // Assumes 1 exercise per day on maximum!
    // Returns 1 to 15
    List<DateTime> last15Days = new List();
    final exercises = await ExerciseMadeRepository().getAllExercisesMade(query: [DateTime.now().subtract(new Duration(days: 15)), DateTime.now()]);
    for(ExerciseMade exercise in exercises) {
      last15Days.add(exercise.dtdone);
    }
    // Descending sort:
    last15Days.sort((b, a) => a.compareTo(b));
    int daysInSequence = 1;
    DateTime dtNow = DateTime.now();
    DateTime lastDt = DateTime(dtNow.year, dtNow.month, dtNow.day);
    for(DateTime dtDone in last15Days){
      if(dtDone.difference(lastDt) >= Duration(days: 1, hours: 12)){
        return daysInSequence;
      }
      else {
        daysInSequence = daysInSequence + 1;
      }
    }
    return daysInSequence;
  }
  static double calculateRawXp(ExerciseMade exercise) {
    double xp = 0;
    if(exercise.pushups != 0){
      xp = xp + exercise.pushups;
    }
    if(exercise.situps != 0){
      xp = xp + exercise.situps;
    }
    if(exercise.squats != 0){
      xp = xp + exercise.squats;
    }
    if(exercise.run != 0){
      xp = xp + exercise.run * 3;
    }
    return xp;
  }
  static double calculateMultStreak(int streak) {
    if(streak >= 15) return 2;
    if(streak >= 7) return 1;
    if(streak >= 5) return 0.5;
    if(streak >= 2) return 0.2;
    return 0;
  }
  static double calculateMultStreakXP(int streak, double xp) {
    double mult = calculateMultStreak(streak);
    return xp * mult;
  }
  static double calculateMultCompletedXP(double xp){
    return xp * 0.5;
  }
  static Future<int> calculateXpFromExerciseMade(ExerciseMade exercise) async {
    int streak = await getExerciseStreak();
    double totalGainedXp = calculateRawXp(exercise);
    totalGainedXp = totalGainedXp + calculateMultCompletedXP(totalGainedXp);
    totalGainedXp = totalGainedXp + calculateMultStreakXP(streak, totalGainedXp); 
    return totalGainedXp.ceil();
  }
  static void registerExercise(ExerciseMade exercise) async {
    int xpCalculated = await calculateXpFromExerciseMade(exercise);
    addPlayerXp(xpCalculated);
  }


}