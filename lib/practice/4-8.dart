import '../components.dart';

import 'package:flutter/material.dart';

class MyPress extends StatefulWidget {
  @override
  _MyPressState createState() => new _MyPressState();
}

// class _MyPressState extends State<MyPress> {
//   PointerEvent _event;
//   int parentClick = 0;
//   int childClick = 0;
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         appBar: MyAppBar('RowStart'),
//         body: Center(
//             child: Listener(
//                 onPointerDown: (event) => setState(() => {
//                       parentClick = parentClick + 1,
//                       print('Parent: $parentClick')
//                     }),
//                 child: Container(
//                   color: Colors.red,
//                   constraints: BoxConstraints.expand(),
//                   child: UnconstrainedBox(
//                     // behavior: HitTestBehavior.opaque,
//                     child: Listener(
//                       child: ConstrainedBox(
//                         constraints: BoxConstraints.tight(Size(300.0, 150.0)),
//                         // child: Container(
//                         // color: Colors.blue,
//                         child: Text("Box A"),
//                         // ),
//                       ),
//                       behavior: HitTestBehavior.deferToChild,
//                       onPointerDown: (event) => setState(() => {
//                             childClick = childClick + 1,
//                             print('Child: $childClick')
//                           }),
//                     ),
//                   ),
//                 ))));
//   }
// }

class _MyPressState extends State<MyPress> {
  PointerEvent _event;
  int parentClick = 0;
  int child1Click = 0;
  int child2Click = 0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: MyAppBar('RowStart'),
        body: Center(
          child: Listener(
            child: Stack(
              children: <Widget>[
                Listener(
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tight(Size(400.0, 200.0)),
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.blue)),
                  ),
                  onPointerDown: (event) => setState(() => {
                        child1Click = child1Click + 1,
                        print('Child-1: $child1Click')
                      }),
                ),
                Listener(
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tight(Size(200.0, 100.0)),
                      // child: DecoratedBox(
                      // child: Center(child: Text("左上角200*100范围内非文本区域点击")),
                      // decoration: BoxDecoration(color: Colors.red)),
                      child: Center(child: Text("左上角200*100范围内非文本区域点击")),
                    ),
                    onPointerDown: (event) => setState(() => {
                          child2Click = child2Click + 1,
                          print('Child-2: $child2Click')
                        }),
                    behavior: HitTestBehavior.opaque //放开此行注释后可以"点透"
                    )
              ],
            ),
            onPointerDown: (event) => setState(() =>
                {parentClick = parentClick + 1, print('Parent: $parentClick')}),
          ),
        ));
  }
}
