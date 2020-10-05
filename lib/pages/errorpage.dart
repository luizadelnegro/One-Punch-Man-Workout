import 'package:flutter/material.dart';
import 'custom_assets/custom_scaffold.dart';

// class ErrorPage {
//   static Route<dynamic> showPage(){
//     return MaterialPageRoute(builder: (_){
//       return Scaffold(
//         appBar: AppBar(
//           title: Text("Error! 404"),
//         ),
//         body: Center(
//           child: Text("ERROR")
//         ),
//       );
//     });
//   }
// }

class ErrorPage extends StatelessWidget {
  ErrorPage({this.errormsg});

  final String errormsg;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [Text("ERROR! This should not happen..."), Text(errormsg)],
      ),
      title: "Error",
    );
  }
}
