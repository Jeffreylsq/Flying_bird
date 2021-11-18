import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final int curScore;
  final int finalScore;
  const ScoreBoard({
    Key? key,
    required this.curScore,
    required this.finalScore,
  }) : super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          //We need to show the content so use decoration image
          image: DecorationImage(image: AssetImage("assets/images/land.png"),
              fit: BoxFit.fill)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,  //spaceAround, left right have space
          //Have space in left and right
          crossAxisAlignment: CrossAxisAlignment.center,  // place in the center
          //place in the center of horizontal

          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // place the socre in the center of the height
                children: [
                  Text("Score",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                  Text(curScore.toString(), style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigoAccent))
                ]
            ),

            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // place the socre in the center of the height
                children: [
                  Text("Highest Score",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),

                  Text(finalScore.toString(), style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigoAccent))
                ]
            )
          ]
      ),
    );
  }
}

