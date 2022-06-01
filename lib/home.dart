import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {

  final bool st;
  Welcome(this.st);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment(0, 0),
        child: Text(
            st ? "Ball will go faster the more you hit it": "Instructions: use Left and Right Arrow Key to move\n"
                "Game ends when someone get 3 points\n\n\n"
                "Click to Begin",
            style: TextStyle(color: Colors.white, fontSize: 50),
            textAlign: TextAlign.center
        ));
  }
}
