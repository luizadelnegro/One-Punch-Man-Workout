import 'package:one_punch_man_workout/model/exercise_made_model.dart';
import 'package:one_punch_man_workout/repository/exercise_made_repository.dart';


import 'dart:async';

class ExerciseMadeBloc {
  final _exerciseMadeRepository = ExerciseMadeRepository();

  final _exerciseMadeController = StreamController<List<ExerciseMade>>.broadcast();

  get exercisesMade => _exerciseMadeController.stream;

  ExerciseMadeBloc();

  getExercisesMade({List<DateTime> query}) async {
    _exerciseMadeController.sink.add(await _exerciseMadeRepository.getAllExercisesMade(query: query));
  }

  addExerciseMade(ExerciseMade exercise) async {
    await _exerciseMadeRepository.insertExerciseMade(exercise);
    getExercisesMade();
  }

  updateExerciseMade(ExerciseMade exercise) async {
    await _exerciseMadeRepository.updateExerciseMade(exercise);
    getExercisesMade();
  }

  deleteExerciseMadeById(int id) async {
    _exerciseMadeRepository.deleteExerciseMadeById(id);
    getExercisesMade();
  }

  dispose() {
    _exerciseMadeController.close();
  }
}