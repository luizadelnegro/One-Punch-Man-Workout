import 'package:flutter/material.dart';

class SwipeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new SwipeImage(),
      onHorizontalDragStart: (e) =>
          Navigator.of(context).pushNamed('/exercise/register'),
    );
  }
}

class SwipeImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      child: Center(
        child: Text(" SWIPE TO START! "),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: new DecorationImage(
            image: new AssetImage('assets/images/fist_button_bw.png')),
      ),
    );
  }
}
