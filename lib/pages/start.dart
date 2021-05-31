import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import '../gmenu.dart';
import './finish.dart';
import '../common/constant.dart';
import '../states/target.dart';
import '../common/util.dart';
import '../common/bus.dart';
import '../common/animation.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => new _StartState();
}

class _StartState extends State<Start> with TickerProviderStateMixin {
  bool isNew = true;
  int dur;
  int repeatTimes;
  int cyberItemCount;
  Animation animation;
  AnimationController animationController;
  TargetListStates targetListContext;

  _StartState({this.dur = 1000, this.repeatTimes = 2, this.cyberItemCount = 7});

  void goToCreateTarget(TargetListStates states) {
    int initialIndex = isNew ? 1 : 0;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                GMenu(initialIndex: initialIndex)));
  }

  @override
  void initState() {
    // 任务完成后，跳转至成就页面
    bus.on("finish", (target) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Finish(target: target)));
    });
    Future.delayed(Duration(milliseconds: (dur * repeatTimes * 1.8).floor()))
        .then((value) => goToCreateTarget(targetListContext));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    targetListContext = context.watch<TargetListStates>();
    targetListContext.checkTargetListStatus();

    return Scaffold(
        body: Container(
      child: Center(
        child: CyberPunk(
          child: Image(image: AssetImage('imgs/panda_cyber.webp')),
          dur: dur,
          maxHeight: 300,
          cyberItemCount: cyberItemCount,
          repeatTimes: repeatTimes,
        ),
      ),
      decoration: BoxDecoration(
        color: Utils.transStr(Constants.colorPandaBG),
      ),
    ));
    // }
  }
}
