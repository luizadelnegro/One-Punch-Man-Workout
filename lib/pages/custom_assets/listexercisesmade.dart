import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:one_punch_man_workout/model/exercise_made_model.dart';
import 'package:one_punch_man_workout/bloc/exercise_made_bloc.dart';

class ListExercisesMade extends StatelessWidget {
  ListExercisesMade({Key key}) : super(key: key);
  final ExerciseMadeBloc exerciseBloc = ExerciseMadeBloc();
  
  Widget ListExercisesMadeStream() {
    return StreamBuilder(
      stream: exerciseBloc.exercisesMade,
      builder: (BuildContext context, AsyncSnapshot<List<ExerciseMade>> snapshot){
        return _ListExercisesMade(snapshot);
      },
    );
  }

  Widget _ListExercisesMade(AsyncSnapshot<List<ExerciseMade>> snapshot) {
    if (snapshot.hasData){
      return snapshot.data.length != 0 ? ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, itemPosition){
          ExerciseMade exercise = snapshot.data[itemPosition];
          final Widget exercise_row = ListTile(
            title: Text(exercise.dtdone.toString()),
          );
          return exercise_row;
        },

      ) : ListTile(
        title: Text("You have not exercised yet!"),
      );
    }
    else {
      return Center(
        child: loadingData(),
      );
    }
  }

  Widget loadingData() {
    exerciseBloc.getExercisesMade();
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Loading...",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container( 
      constraints: BoxConstraints(maxHeight: 300, maxWidth: 400),
      child: ListExercisesMadeStream(),
    );
    
  }
}