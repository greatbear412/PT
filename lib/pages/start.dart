import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import '../gmenu.dart';
import './finish.dart';
import '../common/constant.dart';
import '../states/target.dart';
import '../common/util.dart';
import '../components/text.dart';
import '../common/bus.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => new _StartState();
}

class _StartState extends State<Start> {
  bool isNew = true;

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(NetworkImage(Constants.bgUrl), context);
    final TargetListStates targetListContext =
        context.watch<TargetListStates>();
    final List<Target> targetList = targetListContext.getTargetList();
    isNew = targetList.length == 0;
    final String content = isNew ? '开始吧 :)' : '继续挑战 ？';

    targetListContext.checkTargetListStatus();

    return Scaffold(
        body: Container(
            padding: const EdgeInsets.only(bottom: 50),
            decoration: BoxDecoration(
                color: Utils.transStr(Constants.colorPandaBG),
                image: DecorationImage(
                    image: AssetImage('imgs/panda.webp'), fit: BoxFit.contain)),
            child: Stack(
              children: [
                Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Listener(
                        onPointerDown: (PointerDownEvent event) =>
                            goToCreateTarget(targetListContext),
                        child: Center(
                          child: Container(
                            width: 300,
                            height: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                border: Border.all(color: Colors.white)),
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(CupertinoIcons.star_circle,
                                      size: 40, color: Colors.white),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  MainText(content)
                                ]),
                          ),
                        )))
              ],
            )));
    // }
  }
}
