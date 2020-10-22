import 'package:flutter/material.dart';
import 'pages/custom_assets/validators.dart';
import 'package:one_punch_man_workout/preferences_controller.dart';
import 'package:one_punch_man_workout/size_config.dart';
import 'main.dart';

class WelcomeScreen extends StatelessWidget {
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child:Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(
              left: SizeConfig.blockSizeHorizontal * 10,
              right: SizeConfig.blockSizeHorizontal * 10,
              top: SizeConfig.blockSizeVertical * 2,
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 25),
                  child: Text(
                    "Welcome hero wannabe!\nWhat is your name ?",
                  ),
                ),
                Container(
                  child: TextFormField(
                    validator: Validators.title,
                    decoration: const InputDecoration(
                      hintText: 'Text Input',
                    ),
                    controller: myController,
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: Image.asset('assets/images/fist_button_bw.png'),
                    iconSize: 150.0,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        PreferencesController.setHeroName(myController.text);
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => MyApp()));
                      }
                    },
                  ),
                ),
                Container(
                  height: SizeConfig.blockSizeVertical * 50,
                  width: SizeConfig.blockSizeHorizontal * 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/welcome_image.png'),
                      fit: BoxFit.cover,
                    ),
                  )
                ),
              ],
            )
          )
        )
      )
    );
  }
}
