import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import '../menu.dart';
import '../common/constant.dart';
import '../states/target.dart';
import '../common/util.dart';
import '../components/text.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => new _StartState();
}

class _StartState extends State<Start> {
  bool isNew;

  void goToCreateTarget(TargetListStates states) {
    int initialIndex = isNew ? 1 : 0;
    pushNewScreen(context, screen: MainMenu(initialIndex: initialIndex));
  }

  @override
  Widget build(BuildContext context) {
    final TargetListStates targetListContext =
        context.watch<TargetListStates>();
    final List<Target> targetList = targetListContext.getTargetList();
    isNew = targetList.length == 0;
    final String content = isNew ? '开始吧 :)' : '继续挑战 ？';

    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('imgs/panda.jpg'), fit: BoxFit.cover)),
            child: Stack(
              children: [
                Positioned(
                    bottom: 50,
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
                                color: Utils.transStr(Constants.colorActive)),
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
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
