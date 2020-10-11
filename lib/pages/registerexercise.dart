import 'package:flutter/material.dart';
import 'custom_assets/addlayout.dart';
import 'custom_assets/validators.dart';
import 'package:one_punch_man_workout/buttons/checkbox_form_listtile.dart';
import 'package:intl/intl.dart';
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Date: "),
              Text(formatted)
              ],)
          ),
          CheckboxFormListTile(
            title: Text("10 Abdominais"),
            secondary: Icon(Icons.ac_unit),  
          ),
          CheckboxFormListTile(
            title: Text("10 Flexões"),
            secondary: Icon(Icons.ac_unit),  
          ),
          CheckboxFormListTile(
            title: Text("10 Agachamentos"),
            secondary: Icon(Icons.ac_unit),  
          ),
          CheckboxFormListTile(
            title: Text("1KM Corrida"),
            secondary: Icon(Icons.ac_unit),  
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
