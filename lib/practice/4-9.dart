import '../components.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class MyDrag extends StatefulWidget {
  @override
  GestureConflictTestRouteState createState() =>
      new GestureConflictTestRouteState();
}

class GestureConflictTestRouteState extends State<MyDrag> {
  double _left = 0.0;
  double _leftB = 0.0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            top: 80.0,
            left: _leftB,
            child: Listener(
                onPointerDown: (details) {
                  print("p");
                },
                onPointerUp: (details) {
                  //会触发
                  print("up");
                },
                child: Listener(
                    onPointerDown: (details) {
                      print("c");
                    },
                    onPointerUp: (details) {
                      //会触发
                      print("up");
                    },
                    child: (GestureDetector(
                      child: CircleAvatar(child: Text("B")),
                      onTapDown: (TapDownDetails details) {
                        print("on Gesture DOwn");
                      },
                      onHorizontalDragUpdate: (DragUpdateDetails details) {
                        setState(() {
                          _leftB += details.delta.dx;
                        });
                      },
                      onHorizontalDragEnd: (details) {
                        print("onHorizontalDragEnd");
                      },
                    )))))
      ],
    );
  }
}
