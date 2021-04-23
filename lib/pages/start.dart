import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './edit.dart';
import '../common/constant.dart';
import '../states/target.dart';
import '../common/util.dart';
import '../components/text.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => new _StartState();
}

class _StartState extends State<Start> {
  void createTarget() {
    Navigator.pushNamed(context, 'edit_target');
  }

  @override
  Widget build(BuildContext context) {
    final targetListContext = context.watch<TargetListStates>();
    final List<Target> targetList = targetListContext.getTargetList();
    final String content = targetList.length > 0 ? '继续挑战 ？' : '开始吧。';

    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('imgs/panda.jpg'), fit: BoxFit.cover)),
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Listener(
                    onPointerDown: (PointerDownEvent event) => createTarget(),
                    child: Center(
                      child: Container(
                        width: 300,
                        height: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: Utils.transStr(Constants.colorError)),
                        child: MainText(content),
                      ),
                    )))
          ],
        ));
    // }
  }
}
