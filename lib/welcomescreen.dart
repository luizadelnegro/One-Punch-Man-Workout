import 'package:flutter/material.dart';
import 'package:one_punch_man_workout/pages/custom_assets/custom_scaffold.dart';
import 'pages/custom_assets/validators.dart';
import 'package:one_punch_man_workout/preferences_controller.dart';
import 'package:one_punch_man_workout/size_config.dart';
import './buttons/main_button.dart';

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
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 20.0,
                    right: 30.0,
                    left: 30.0,
                  ),
                  child: Text("Welcome hero wannabe! What is your name ?"),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 50.0,
                    left: 30.0,
                    right: 30.0,
                  ),
                  child: TextFormField(
                    validator: Validators.title,
                    decoration: const InputDecoration(
                      hintText: 'Text Input',
                    ),
                    controller: myController,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 100.0,
                    left: 60.0,
                  ),
                  child: MainButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        PreferencesController.setHeroName(myController.text);
                        Navigator.of(context).pushNamed('/');
                      }
                    },
                    child: Text('Enviar'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 160.0,
                    left: 30.0,
                  ),
                  child: Image.asset('assets/images/welcome_image.png',
                      height: SizeConfig.blockSizeVertical * 100,
                      width: SizeConfig.blockSizeHorizontal * 90),
                ),
              ],
            )));
  }
}
