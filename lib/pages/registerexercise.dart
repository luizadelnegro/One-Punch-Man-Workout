import 'dart:ffi';

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'custom_assets/addlayout.dart';
import 'custom_assets/validators.dart';
import 'package:one_punch_man_workout/buttons/checkbox_form_listtile.dart';
import 'package:intl/intl.dart';
import 'package:one_punch_man_workout/size_config.dart';
import 'package:one_punch_man_workout/bloc/exercise_made_bloc.dart';
import 'package:one_punch_man_workout/model/exercise_made_model.dart';

class RegisterExerciseForm extends StatefulWidget {
  _RegisterExerciseFormState createState() => _RegisterExerciseFormState();
}

class _RegisterExerciseFormState extends State<RegisterExerciseForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    ExerciseMade exercise = ExerciseMade();
    ExerciseMadeBloc bloc = ExerciseMadeBloc();
    exercise.dtdone = now;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Date: "), Text(formatted)],
              )),
          CheckboxFormListTile(
            title: Text("10 Abdominais"),
            secondary: Image.asset(
              'assets/images/abd_bw.png',
              height: SizeConfig.blockSizeVertical * 30,
              width: SizeConfig.blockSizeHorizontal * 30,
            ),
            onSaved: (bool value) {
              if(value){
                exercise.situps = 10;
              }
              else {
                exercise.situps = 0;
              }
            },
          ),
          CheckboxFormListTile(
            title: Text("10 Flexões"),
            secondary: Image.asset(
              'assets/images/flex_bw.png',
              height: SizeConfig.blockSizeVertical * 30,
              width: SizeConfig.blockSizeHorizontal * 30,
            ),
            onSaved: (bool value) {
              if(value){
                exercise.pushups = 10;
              }
              else {
                exercise.pushups = 0;
              }
            },
            
          ),
          CheckboxFormListTile(
            title: Text("10 Agachamentos"),
            secondary: Image.asset(
              'assets/images/squat_bw.png',
              height: SizeConfig.blockSizeVertical * 30,
              width: SizeConfig.blockSizeHorizontal * 30,
            ),
            onSaved: (bool value) {
              if(value){
                exercise.squats = 10;
              }
              else {
                exercise.squats = 0;
              }
            },
          ),
          CheckboxFormListTile(
            title: Text("1KM Corrida"),
            secondary: Image.asset(
              'assets/images/run_bw.png',
              height: SizeConfig.blockSizeVertical * 30,
              width: SizeConfig.blockSizeHorizontal * 30,
            ),
            onSaved: (bool value) {
              if(value){
                exercise.run = 1.0;
              }
              else {
                exercise.run = 0.0;
              }
            },
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing')));
                  _formKey.currentState.save();
                  print(exercise.completed);
                  if(exercise.pushups == 10 && exercise.run == 1.0 && exercise.situps == 10 && exercise.squats == 10){
                    exercise.completed = true;
                  }
                  else {
                    exercise.completed = false;
                  }
                  bloc.addExerciseMade(exercise);
                  Scaffold.of(context).removeCurrentSnackBar();
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Completed')));
                  print("Comp");
                }

              },
              child: Text('Enviar'),
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterExercise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AddLayout(
      body: RegisterExerciseForm(),
      object: "Register Exercise!",
    );
  }
}
