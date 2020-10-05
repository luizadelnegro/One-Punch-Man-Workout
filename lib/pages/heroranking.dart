import 'package:flutter/material.dart';

class HeroRanking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Ranking';
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
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
      ),
    );
  }
}
