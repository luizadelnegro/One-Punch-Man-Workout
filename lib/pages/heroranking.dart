import 'package:flutter/material.dart';
import 'custom_assets/custom_barless_scaffold.dart';

class HeroRanking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Ranking';
    return CustomBarlessScaffold(
      children: [
        ListTile( 
          title: Text("Saitama"),
          subtitle: Text("The best"),
        )
      ],
    );
  }
}
