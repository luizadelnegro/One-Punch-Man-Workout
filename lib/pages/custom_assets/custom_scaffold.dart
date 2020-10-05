import 'package:flutter/material.dart';
import '../../drawer.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../../theme.dart' as Theme;

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  CustomScaffold({this.body, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      backgroundColor: Theme.CompanyColors.red[100],
      body: body,
      drawer: SideMenu(),
    );
  }
}
