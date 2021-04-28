import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

import '../common/constant.dart';
import '../states/target.dart';
import '../common/util.dart';
import '../components/text.dart';
import '../components/common.dart';

class Detail extends StatefulWidget {
  final Target target;
  Detail(this.target);

  @override
  _DetailState createState() => new _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Utils.transStr('000'),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Center(
                    child: Image(
                        image: AssetImage('imgs/detail.webp'),
                        repeat: ImageRepeat.noRepeat,
                        width: Utils.getScreenWidth(context)))),
            Container(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  // height: 200,
                  color: Colors.black.withOpacity(0.3),
                  // padding: const EdgeInsets.only(bottom: 100),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      TableCalendar(
                        firstDay: widget.target.startTime,
                        lastDay: DateTime.now(),
                        focusedDay: DateTime.now(),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
