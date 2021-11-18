import 'package:flutter/cupertino.dart';

enum Direction{Up, Down}
const double birdX = -0.9;
const double birdSize = 40;
class Bird extends StatelessWidget {
  const Bird({
    Key? key,
    required this.birdY,
  }) : super(key: key);

  final double birdY;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(    //can update and control any parameter value BirdY
        duration: Duration(milliseconds: 0),    //Once the BirdY changed in this duration
        curve: Curves.linear,   // We can update the dump curve style
        //Bird start position
        alignment: Alignment(birdX, birdY),  // the birdY should be changed so
        child: Container(
          //Add containter we can controll bird size
            width: birdSize,
            height: birdSize,
            //add bird pic in the images
            child: Image.asset("assets/images/bird.png"))
    );
  }
}