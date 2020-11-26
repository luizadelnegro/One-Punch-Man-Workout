import 'package:flutter/material.dart';
import '../../drawer.dart';

class CustomBarlessScaffold extends StatelessWidget {
  CustomBarlessScaffold({this.children});

  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        drawer: SideMenu(),
        body: Stack(          
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                child: RaisedButton(
                  child: Icon(Icons.clear_all),
                  onPressed: () =>
                      _scaffoldKey.currentState.openDrawer(),
                  color: Theme.of(context).primaryColor,
                )
              )
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: children
            ),
          ],
        ) 
      )
      );
  }
}