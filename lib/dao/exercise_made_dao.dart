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

  Future<List<ExerciseMade>> getExercisesMade({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty) {
        String dateini = DateTime(int.parse(query.split("/")[0]), int.parse(query.split("/")[1]), 1).millisecondsSinceEpoch.toString();
        String datefin = DateTime(int.parse(query.split("/")[0]), int.parse(query.split("/")[1]) + 1, 0).millisecondsSinceEpoch.toString() ;
        result = await db.query(exerciseMadeTable,
            columns: columns,
            where: "dtdone >= ? AND dtdone <= ?",
            whereArgs: [dateini, datefin]);
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
}