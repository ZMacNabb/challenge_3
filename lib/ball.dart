import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  final xdir;
  final ydir;
  Ball(this.xdir, this.ydir);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(xdir, ydir),

      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        width: 30,
        height: 30,
      ),
    );
  }
}
