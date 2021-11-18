import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // start game position
        alignment: Alignment(0, -0.2),
        child: Container(
            child: Text("Tag to Start Game",
                style: TextStyle(fontSize: 36, color: Colors.green)))

      );

  }
}