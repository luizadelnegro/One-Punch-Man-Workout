import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:one_punch_man_workout/size_config.dart';
import 'custom_assets/custom_barless_scaffold.dart';
import 'package:flutter/services.dart' show rootBundle;


class HeroRanking extends StatefulWidget {
  @override
  _HeroRankingState createState() => _HeroRankingState();
}

class _HeroRankingState extends State<HeroRanking> {

  Future<List<dynamic>> getJsonHeros() async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/data/herosrank.json");
    return json.decode(data);
  }

  int getNumOfBlocksPerRow() {
    final one_percent_screen_size = SizeConfig.blockSizeHorizontal;
    if (one_percent_screen_size > 3) {
      return 2;
    }
    else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder( 
      future: getJsonHeros(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          return Scaffold(
            body:
              GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: getNumOfBlocksPerRow(),
                  mainAxisSpacing: 4,
                ), 
                itemBuilder: (BuildContext context, int index) {
                    String image_str = snapshot.data[index]["image"];
                    return Card( 
                      child: Stack( 
                        children: [
                          if(image_str != null) Container(child: Image.network(image_str, fit: BoxFit.fill,), alignment: Alignment.center,),
                          Container(
                            child: Column( 
                              children: [
                                ListTile( 
                                  title: Text("Class " + snapshot.data[index]['class'], style: TextStyle(backgroundColor: Colors.white),),
                                  subtitle: Text("Rank - " + snapshot.data[index]['rank'].toString(), style: TextStyle(backgroundColor: Colors.white),),
                                ),
                                Center( 
                                  child: Text(snapshot.data[index]['name'], style: TextStyle(backgroundColor: Colors.white),),
                                )
                              ],
                            )
                          )
                        ]
                      )
                    );
                }
              ),
            
          );
        }
        else {
          //print(getJsonHeros());
          return CustomBarlessScaffold( 
            children: [
              Container( 
                height: SizeConfig.blockSizeVertical*5,
                width: SizeConfig.blockSizeHorizontal*5,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  
                )
              ),
            ],
          );
        }
      }
    );
  }
}
