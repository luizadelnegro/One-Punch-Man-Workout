import 'dart:async';
import 'package:one_punch_man_workout/database.dart';
import 'package:one_punch_man_workout/model/exercise_made_model.dart';

class ExerciseMadeDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<int> createExerciseMade(ExerciseMade exercise) async {
    final db = await dbProvider.database;
    var result = db.insert(exerciseMadeTable, exercise.toDatabaseJson());
    return result;
  }

  Future<List<ExerciseMade>> getExercisesMade({List<String> columns, List<DateTime> query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty) {

        String dateIni = query[0].millisecondsSinceEpoch.toString();
        String dateFin = query[1].millisecondsSinceEpoch.toString();

        result = await db.query(exerciseMadeTable,
            columns: columns,
            where: "dtdone >= ? AND dtdone <= ?",
            whereArgs: [dateIni, dateFin]);
      }
    } else {
      result = await db.query(exerciseMadeTable, columns: columns);
    }

    List<ExerciseMade> exercises = result.isNotEmpty
        ? result.map((item) => ExerciseMade.fromDatabaseJson(item)).toList()
        : [];
    return exercises;
  }

  Future<int> updateExerciseMade(ExerciseMade exercise) async {
    final db = await dbProvider.database;

    var result = await db.update(exerciseMadeTable, exercise.toDatabaseJson(),
        where: "dtdone = ?", whereArgs: [exercise.dtdone]);

    return result;
  }

  Future<int> deleteExerciseMade(int dtdone) async {
    final db = await dbProvider.database;
    var result = await db.delete(exerciseMadeTable, where: 'dtdone = ?', whereArgs: [dtdone]);
    return result;
  }

  Future<void> deleteAll() async {
    // For debugging
    final db = await dbProvider.database;
    db.delete(exerciseMadeTable);
  }
}