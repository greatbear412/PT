import 'package:flutter/material.dart';

import 'dart:math' as math;
// import '../components.dart';

class Trans extends StatelessWidget {
  final String color = 'ff0000';

  @override
  Widget build(BuildContext context) {
    return new Material(
        child: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 80,
          height: 30,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Color(int.parse(color, radix: 16)).withAlpha(150)),
              child: Transform.scale(
                scale: 1,
                child: Transform.rotate(
                  angle: math.pi / 2, //旋转90度
                  child: Transform.translate(
                    offset: Offset(-50.0, -5.0),
                    child: Text("Hello world"),
                  ),
                ),
              )),
        ),
        Text(
          "你好",
          style: TextStyle(color: Colors.green, fontSize: 18.0),
        )
      ],
    ));
  }
}

// class Trans extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new Material(
//         child: new Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         SizedBox(
//           width: 80,
//           height: 30,
//           child: DecoratedBox(
//               decoration: BoxDecoration(color: Colors.red),
//               child: Transform.scale(
//                 scale: 1,
//                 child: Transform.translate(
//                   offset: Offset(-50.0, -5.0),
//                   // child: Transform.rotate(
//                   // angle: math.pi / 2,
//                   child: Text('Hello World'), //旋转90度
//                   // ),
//                 ),
//               )),
//         ),
//         Text(
//           "你好",
//           style: TextStyle(color: Colors.green, fontSize: 18.0),
//         )
//       ],
//     ));
//   }
// }
