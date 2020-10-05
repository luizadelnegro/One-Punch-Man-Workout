import 'package:flutter/material.dart';

final entries = [
  {'title': 'Home', 'routename': '/'},
  {'title': 'Progress', 'routename': '/progress'},
  {'title': 'Ranking', 'routename': '/ranking'},
];

class SideMenu extends StatelessWidget {
  SideMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: DrawerHeader(
                child: Center(
                  child: Text('Hero Name'),
                ),
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
              )),
          Expanded(
              flex: 4,
              child: ListView.separated(
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(entries[index]['title']),
                    onTap: () {
                      // Update the state of the app then close the drawer
                      Navigator.of(context)
                          .pushNamed(entries[index]['routename']);
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ))
        ],
      ),
    );
  }
}
