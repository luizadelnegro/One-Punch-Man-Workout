
import 'package:one_punch_man_workout/dao/exercise_made_dao.dart';
import 'package:one_punch_man_workout/model/exercise_made_model.dart';

class ExerciseMadeRepository {
  final exerciseMadeDao = ExerciseMadeDao();

  Future getAllExercisesMade({List<DateTime> query}) => exerciseMadeDao.getExercisesMade(query: query);

  Future insertExerciseMade(ExerciseMade exercise) => exerciseMadeDao.createExerciseMade(exercise);

  Future updateExerciseMade(ExerciseMade exercise) => exerciseMadeDao.updateExerciseMade(exercise);

  Future deleteExerciseMadeById(int id) => exerciseMadeDao.deleteExerciseMade(id);
}