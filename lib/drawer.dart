import 'package:flutter/material.dart';
import 'package:one_punch_man_workout/preferences_controller.dart';

final entries = [
  {'title': 'Home', 'routename': '/'},
  {'title': 'Progress', 'routename': '/progress'},
  {'title': 'Ranking', 'routename': '/ranking'},
];

class SideMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SideMenuState();
}
class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: FutureBuilder( 
                future: PreferencesController.getHeroName(),
                builder: (context, snapshot){
                  final heroname = snapshot.data;
                  return DrawerHeader(
                    child: Center(
                      child: Row( 
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('$heroname'),
                          IconButton(
                            alignment: Alignment.topRight,
                            onPressed: () => Navigator.of(context).pushNamed('/welcome'),
                            icon: Icon(Icons.edit),

                          )
                        
                        ]
                      )
                    ),
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                  );
                } 
              )
          ),
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
