import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double pipWidth = 60;

class Pipe extends StatelessWidget {
  const Pipe({
    Key? key,
    required this.pipeX,
    required this.pipeY,
    required this.pipeSize,
  }) : super(key: key);

  final double pipeX;
  final double pipeY;
  final double pipeSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      // position
      alignment: Alignment(pipeX, pipeY),
      //use containter to design pipe
      child: Container(
          decoration:BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(10)),
             // border: Border.all(width: 1, color: Colors.blue)
          ),
          width: pipWidth,
          height: pipeSize,
          child: Image.asset("assets/images/pipe.png", fit: BoxFit.fill),
          ) // obstacles height and width
    );
  }
}