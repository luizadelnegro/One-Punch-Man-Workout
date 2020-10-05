import 'package:flutter/material.dart';
import '../../drawer.dart';


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
      backgroundColor: Theme.of(context).backgroundColor,
      body: body,
      drawer: SideMenu(),
    );
  }
}
