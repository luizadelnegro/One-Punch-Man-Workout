

import 'dart:ffi';

class ExerciseMade {
  int id;
  DateTime dtdone;
  int pushups;
  int situps;
  int squats;
  double run; // KM
  bool completed;
  ExerciseMade({this.id, this.dtdone, this.pushups, this.situps, this.squats, this.run, this.completed});

  factory ExerciseMade.fromDatabaseJson(Map<String, dynamic> data) => ExerciseMade(
        id: data['id'],
        dtdone: DateTime.fromMillisecondsSinceEpoch(data['dtdone']),
        pushups: data['pushups'],
        situps: data['situps'],
        squats: data['squats'],
        run: data['run'],
        completed: data['completed'] == 0 ? false : true,
      );
  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "dtdone": dtdone.millisecondsSinceEpoch,
        "pushups": this.pushups,
        "situps": this.situps,
        "squats": this.squats,
        "run": this.run,
        "completed": this.completed == false ? 0 : 1,
      };
}