import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:challenge3/ball.dart';
import 'package:challenge3/brick.dart';
import 'package:challenge3/home.dart';
void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pong',
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}
enum direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  double controlled =  0;
  double width = 0.4;
  int score = 0;
  double ai = 0;
  int aiscore = 0;
  double bx = 0;
  double by = 0;
  double delay=0;
  double hit=0;
  var byd = direction.DOWN;
  var bxd = direction.RIGHT;
  bool st = false;
  void startGame() {
    st = true;
    Timer.periodic(Duration(milliseconds: 1), (timer) {
      direc();
      balldirec();
      moveai();
      if (aiscored()) {
        aiscore++;
        timer.cancel();
        text(false);
        // restart();
      }
      if (youscored()) {
        score++;
        timer.cancel();
        text(true);
        // restart();
      }
    });
  }

  void text(bool AIDied) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(

            backgroundColor: Colors.black,
            title: Center(
                child: aiscore  <3 && score <3?
                Text(AIDied?"You scored": "AI scored",
                  style: TextStyle(color:AIDied?Colors.green: Colors.blue, fontSize:30),
                ):
                Text("Game Over",
                  style: TextStyle(color: Colors.white, fontSize:30),
                )
            ),
            actions: [
              GestureDetector(

                onTap: restart,
                child: ClipRRect(
                    child: aiscore  <3 && score <3?
                    Text("Next Point",
                      style: TextStyle(color:AIDied?Colors.green: Colors.blue, fontSize:50),
                      textAlign: TextAlign.center,
                    ):
                    Text("New game",
                      style: TextStyle(color: Colors.white, fontSize: 50),
                      textAlign: TextAlign.center,
                    )),
              ),

            ],
          );
        });
  }

  bool youscored(){
    if (by <= -1) {
      return true;
    }
    return false;
  }

  void moveai() {
    setState(() {
      ai = bx-delay;
    });
  }
  void restart() {
    Navigator.pop(context);
    setState(() {
      st = false;
      bx=0;
      by=0;
      controlled=-0.2;
      ai=-0.2;
      delay=0;
      hit=0;
      if (aiscore>=03 || score >=3 ) {
        aiscore=0;
        score =0;
      }
    });
  }


  bool aiscored() {
    if (by >= 1) {
      return true;
    }
    return false;
  }

  void direc() {

    setState(() {
      if (by >= 0.9 && controlled + width>= bx && controlled  <= bx) {
        byd = direction.UP;
        delay=delay+0.075;
        hit=hit+0.0005;
      } else if (by <= -0.9  && ai + width>= bx && ai  <= bx) {
        byd = direction.DOWN;
      }
      if (bx >= 1) {
        bxd = direction.LEFT;
      } else if (bx <= -1) {
        bxd = direction.RIGHT;
      }
    });
  }

  void balldirec() {
    //vertical movement
    setState(() {
      if (byd == direction.DOWN) {
        by += 0.004+hit;
      } else if (byd == direction.UP) {
        by -= 0.004+hit;
      }
    });
    //horizontal movement
    setState(() {
      if (bxd == direction.LEFT) {
        bx -= 0.002+hit*2;
      } else if (bxd == direction.RIGHT) {
        bx += 0.002+hit*2;
      }
    });
  }

  void left() {
    setState(() {
      if (!(controlled - 0.1 <= -1)) {
        controlled -= 0.25;
      }
    });
  }

  void right() {
    if (!(controlled + width >= 1)) {
      controlled += 0.25;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          left();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          right();
        }
      },
      child: GestureDetector(
        onTap: startGame,
        child: aiscore  ==0 && score ==0?
        Scaffold(
            backgroundColor: Colors.black,
            body: Center(
                child:  Stack(
                  children: [
                    Welcome(st),
                    Brick(ai, -0.9, width, true),
                    Score(st,aiscore,score
                    ),
                    Ball(bx, by),
                    Brick(controlled, 0.9, width, false)
                  ],
                ))):
        Scaffold(
            backgroundColor: Colors.black,
            body: Center(
                child:  Stack(
                  children: [

                    Brick(ai, -0.9, width, true),
                    Score(st,aiscore,score
                    ),
                    Ball(bx, by),
                    Brick(controlled, 0.9, width, false)
                  ],
                )))
        ,

      ),
    );
  }
}

class Score extends StatelessWidget {
  final st;
  final aiscore;
  final score
  ;
  Score(this.st, this.aiscore,this.score
      , );

  @override
  Widget build(BuildContext context) {
    return st? Stack(children: [

      Container(
          alignment: Alignment(0.8, -0.1),
          child: Text(
            aiscore.toString(),
            style: TextStyle(color: Colors.blue, fontSize: 50),
          )),
      Container(
          alignment: Alignment(0.8, 0.1),
          child: Text(
            score
                .toString(),
            style: TextStyle(color: Colors.green, fontSize: 50),
          )),
    ]): Container();
  }
}



