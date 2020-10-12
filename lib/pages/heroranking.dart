import 'dart:convert';

import 'package:flutter/material.dart';
import 'custom_assets/custom_barless_scaffold.dart';


class HeroRanking extends StatefulWidget {
  @override
  _HeroRankingState createState() => _HeroRankingState();
}

class _HeroRankingState extends State<HeroRanking> {

  Stream<String> getJsonHeros() {
    return DefaultAssetBundle.of(context).loadString("assets/data/herosrank.json");
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder( 
      stream: getJsonHeros(),
    )
  }
}
