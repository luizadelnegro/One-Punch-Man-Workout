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
      if (query.isNotEmpty)
        result = await db.query(exerciseMadeTable,
            columns: columns,
            where: 'description LIKE ?',
            whereArgs: ["%$query%"]);
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
        where: "id = ?", whereArgs: [exercise.id]);

    return result;
  }

  Future<int> deleteExerciseMade(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(exerciseMadeTable, where: 'id = ?', whereArgs: [id]);
    return result;
  }
}