import 'package:flutter/material.dart';
import 'package:one_punch_man_workout/preferences_controller.dart';
import 'size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List get_entries(BuildContext context) {
  return [
    {'title': AppLocalizations.of(context).home, 'routename': '/'},
    {'title': AppLocalizations.of(context).progress, 'routename': '/progress'},
    {'title': AppLocalizations.of(context).ranking, 'routename': '/ranking'},
  ];
}
class SideMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SideMenuState();
}
class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    final entries = get_entries(context);
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
                    child: 
                    Stack(  
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  child: Text("Avatar"),
                                  backgroundColor: Theme.of(context).backgroundColor,
                                  radius: SizeConfig.blockSizeHorizontal * 7,
                              ),                       
                              Text('$heroname'),
                            ]
                          )
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () => Navigator.of(context).pushNamed('/welcome'),
                            icon: Icon(Icons.edit),
                          )
                        )
                      ]
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
                    title: Text(entries[index]['title'], style: TextStyle(color: Theme.of(context).backgroundColor),),
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
