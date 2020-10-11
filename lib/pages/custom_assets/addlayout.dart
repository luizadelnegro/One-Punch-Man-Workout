import 'package:flutter/material.dart';


class AddLayout extends StatelessWidget {

  final Widget body;
  final String object;


  AddLayout({this.body, this.object});


  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(  
        title: Text(object),
        actions: <Widget>[ 
          IconButton(  
            icon: Icon(Icons.check),
            tooltip: "Confirm",
            onPressed: () => print("Confirmerd"),
          )
        ],
        leading: IconButton(  
          icon: Icon(Icons.clear),
          tooltip: "Cancel",
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: body,
    );
  }
  
}