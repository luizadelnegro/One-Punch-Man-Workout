import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../theme.dart' as Themes;

class HeroRanking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Ranking';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      backgroundColor: Themes.CompanyColors.red[100],
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 1,
        // Generate 10 widgets that display their index in the List.
        children: List.generate(10, (index) {
          return Center(
            child: Text(
              'Ranking $index',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          );
        }),
      ),
    );
  }
}
