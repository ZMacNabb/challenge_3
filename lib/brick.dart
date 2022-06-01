import 'package:flutter/material.dart';

class Brick extends StatelessWidget {
  final xdir;
  final ydir;
  final width;
  final aidir;
  Brick( this.xdir, this.ydir, this.width, this.aidir);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2* xdir +width)/(2-width), ydir),

      child: Container(
        alignment: Alignment(0, 0),
        color: aidir?Colors.white: Colors.white,
        height: 20,
        width:MediaQuery.of(context).size.width * width/ 2,
      ),
    );
  }
}
