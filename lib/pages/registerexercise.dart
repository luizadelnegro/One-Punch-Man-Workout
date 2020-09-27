import 'package:flutter/material.dart';
import 'assets/addlayout.dart';
import 'assets/validators.dart';



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

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: Validators.title,
            decoration: const InputDecoration(
              hintText: 'Text Input',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
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