import 'package:flutter/material.dart';
import 'package:one_punch_man_workout/pages/custom_assets/custom_scaffold.dart';
import 'pages/custom_assets/validators.dart';
import 'package:one_punch_man_workout/preferences_controller.dart';

class WelcomeScreen extends StatelessWidget {
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    // TODO: implement build

    return CustomScaffold(
      title: "WELCOME",
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Text("Welcome hero wannabe! What is your name ?"),
            TextFormField(  
              validator: Validators.title,
              decoration: const InputDecoration(
                hintText: 'Text Input',
              ),
              controller: myController,
            ),
            RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  PreferencesController.setHeroName(myController.text);
                  Navigator.of(context).pushNamed('/');
                  
                }
              },
              child: Text('Enviar'),
            ),
        ],)
      )
    );
  }
  
}