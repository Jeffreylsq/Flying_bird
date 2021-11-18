import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fly_bird/pipe.dart';
import 'package:fly_bird/scoreboard.dart';

import 'Startscreen.dart';
import 'bird.dart';
//21:26
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Fly bird'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key? key, this.title = ''}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

const double gapSize = 0.6;
const double initPipeOneX = 0.5;
const double initPipeTwoX = 0.9;
const double initPipeThreeX = 0;

class _MyHomePageState extends State<MyHomePage> {
  double birdY = 0;
  double birdYLastTime = 0;
  bool isRunning = false;
  double pipeSize = 200;
  double pipeOneX = initPipeOneX;
  double pipeTwoX = initPipeTwoX;
  double pipeThreeX = initPipeThreeX;
  double gapOneCenter = 0.1;
  double gapTwoCenter = 0;
  double gapThreeCenter = 0.3;
  Direction birdDirection = Direction.Down;
  int score = 0;
  int maxScore = 5;
  double time = 0;

  void initGameState(bool isGameOver) {
    setState(() {
      isRunning = !isGameOver;
      pipeOneX = initPipeOneX;
      pipeTwoX = initPipeTwoX;
      pipeThreeX = initPipeThreeX;
      birdY = 0;
      birdYLastTime = 0;
      time = 0;
      score = 0;
    });
  }
  bool checkCrash(double center, pipeX) {
    final double deltaWidth =
        (pipWidth + birdSize) / MediaQuery.of(context).size.width;

    if (pipeX <= birdX + deltaWidth) {
      if ((birdY >= (center + gapSize / 2)) ||
          (birdY <= (center - gapSize / 2) + 0.18)) {
        return true;
      }
    } else if (birdY >= 1) {
      return true;
    }

    return false;
  }

  Timer createTimer() {
    const double g = 9.8;

    return Timer.periodic(Duration(milliseconds: 50), (timer) {
      // move to left
      final double newPipeOneX = pipeOneX - 0.01;
      final double newPipeTwoX = pipeTwoX - 0.01;
      final double newPipeThreeX = pipeThreeX - 0.01;
      bool isCrash = false;

      time += 0.02;
      // -(gt^2) / 2 + vt  Gravity formular
      birdY = -(g / 2) * time * time + 1 * time;
      setState(() {
        birdY = birdYLastTime - birdY;
      });

      isCrash = checkCrash(gapOneCenter, pipeOneX);
      isCrash |= checkCrash(gapTwoCenter, pipeTwoX);
      isCrash |= checkCrash(gapThreeCenter, pipeThreeX);
      if (newPipeOneX <= -1 || newPipeTwoX <= -1 || newPipeThreeX <= -1) {
        setState(() {
          score += 1;
        });
      }

      if (isCrash == true) {
        initGameState(true);

        timer.cancel();
      } else {
        setState(() {
          pipeOneX = newPipeOneX < -1 ? 1.3 : newPipeOneX;
          pipeTwoX = newPipeTwoX < -1 ? 1.3 : newPipeTwoX;
          pipeThreeX = newPipeThreeX < -1 ? 1.3 : newPipeThreeX;
        });
      }

      if (score > maxScore) {
        maxScore = score;
      } else {
        maxScore = maxScore;
      }
    });
  }

  startGame() {
    initGameState(false);
    createTimer();
  }



  onJumpEnd() {
    setState((){
      birdY = 1;
    });
  }
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }



  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 3 / 4;

    return Scaffold(
    appBar: AppBar(
    title: Text(widget.title),

    ),

    body: GestureDetector(
      onTap: (){
        setState(() {
          birdYLastTime = birdY;
          time = 0;
        });
      },
      child: Container(
          //color: Colors.white,
            decoration: BoxDecoration(
            image: new DecorationImage(
            fit: BoxFit.cover,
            image: new NetworkImage(
            'https://images0.cnblogs.com/blog/381412/201411/221434311872356.png'),
            )),
          child:  Stack(
            children: [
              //Divide screen into 2 section
              Column(
                children: [
                /**
                 * bird take up 3/4 space, land take up 1/4 space
                 */
                  Expanded(
                    //75 %
                    flex: 3,
                    child: Stack(children: [                    // size * 3 / 4
                      Pipe(pipeX: pipeOneX, pipeY: -1, pipeSize: maxHeight * (gapOneCenter - gapSize/2 + 1) / 2),
                      Pipe(pipeX: pipeOneX, pipeY: 1, pipeSize: maxHeight * (1 - (gapOneCenter + gapSize / 2)) / 2),
                      Pipe(pipeX: pipeTwoX, pipeY: -1, pipeSize: maxHeight * (gapTwoCenter - gapSize/2 + 1) / 2),
                      Pipe(pipeX: pipeTwoX, pipeY: 1, pipeSize: maxHeight * (1 - (gapTwoCenter + gapSize / 2)) / 2),
                      Pipe(pipeX: pipeThreeX, pipeY: -1, pipeSize: maxHeight * (gapThreeCenter - gapSize/2 + 1) / 2),
                      Pipe(pipeX: pipeThreeX, pipeY: 1, pipeSize: maxHeight * (1 - (gapThreeCenter + gapSize / 2)) / 2),
                      Bird(birdY: birdY),

                    ])),
                Expanded(
                   //25%
                    flex: 1,
                    child: ScoreBoard(curScore: score, finalScore: maxScore))
              ],
            ),

              //Start game
              if (isRunning == false)
                //Catch all the action
                GestureDetector (
                  onTap: (){
                    startGame();
                  },
                  child: StartScreen(),
                )
            ],
          ),
      )
    ),
      backgroundColor: Colors.white,

    );
  }

}





