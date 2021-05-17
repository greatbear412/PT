import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../states/target.dart';
import '../common/util.dart';
import '../common/bus.dart';
import '../common/animation.dart';
import '../components/text.dart';
import '../common/constant.dart';

class CreateTarget extends StatefulWidget {
  final Target target;
  CreateTarget({this.target});

  @override
  _CreateTargetState createState() => new _CreateTargetState();
}

class _CreateTargetState extends State<CreateTarget> {
  Widget child;

  @override
  Widget build(BuildContext context) {
    // precacheImage(AssetImage('imgs/glove.webp'), context);
    final targetListContext = context.watch<TargetListStates>();
    final List<Target> targetListRunning =
        targetListContext.getTargetList(status: 'running');
    if (targetListRunning.length < 3) {
      child = CreateTargetList();
    } else {
      child = Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('imgs/panda_gun.webp'),
              repeat: ImageRepeat.noRepeat,
              width: 100,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainText('足够了 :)'),
                  SizedBox(
                    height: 10,
                  ),
                  StyleText(
                      '已经有三个任务了.',
                      TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
        body: Container(
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
                      image: AssetImage('imgs/create.webp'),
                      repeat: ImageRepeat.noRepeat,
                      fit: BoxFit.contain,
                    ))),
                Container(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                        // height: 200,
                        color: Colors.black.withOpacity(0.3),
                        // padding: const EdgeInsets.only(bottom: 100),
                        alignment: Alignment.center,
                        child: child),
                  ),
                )
              ],
            )));
  }
}

// class
class CreateTargetList extends StatefulWidget {
  final Target target;
  CreateTargetList({this.target});

  @override
  _CreateTargetListState createState() => new _CreateTargetListState();
}

class _CreateTargetListState extends State<CreateTargetList> {
  TextEditingController _utaskController = TextEditingController();
  TextEditingController _udaysController = TextEditingController();
  String toastText = '';

  Widget errorGloveWidget = Image(
    image: AssetImage('imgs/glove_error.webp'),
    repeat: ImageRepeat.noRepeat,
    width: 100,
  );
  Widget goodGloveWidget = Image(
    image: AssetImage('imgs/glove.webp'),
    repeat: ImageRepeat.noRepeat,
    width: 100,
  );
  Widget gloveWidget;
  bool status = false;

  void submit(TargetListStates contextStates) {
    if (status == true) {
      contextStates.create(
          _utaskController.text, int.parse(_udaysController.text.toString()));
      _utaskController.clear();
      _udaysController.clear();
      checkValid();
      Utils.showCommonToast(toastText, Utils.transStr(Constants.colorSuccess));
    }
  }

  void onTaskChange(String days) {
    checkValid();
  }

  void onDaysChange(String days) {
    if (days != null && days != '' && int.parse(days.toString()) > 365) {
      _udaysController.value = TextEditingValue(text: '365');
    }
    checkValid();
  }

  void checkValid() {
    status = _utaskController.text != '' && _udaysController.text != '';
    setGlove();
  }

  void setGlove() {
    if (status == true) {
      gloveWidget = goodGloveWidget;
    } else {
      gloveWidget = errorGloveWidget;
    }
    bus.emit("transferGlove", {'key': 'create', 'body': gloveWidget});
  }

  @override
  void initState() {
    super.initState();
    toastText = '创建成功！';
    checkValid();
  }

  @override
  Widget build(BuildContext context) {
    final targetListContext = context.watch<TargetListStates>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFieldWidget(
            controller: _utaskController,
            labelText: "任务",
            style: TextStyle(color: Colors.white),
            onChange: onTaskChange),
        TextFieldWidget(
            controller: _udaysController,
            keyboardType: TextInputType.number,
            labelText: "期限(最大365)",
            style: TextStyle(color: Colors.white),
            onChange: onDaysChange,
            formatter: [WhitelistingTextInputFormatter(RegExp("[0-9]"))]),
        Listener(
            onPointerDown: (PointerDownEvent event) =>
                submit(targetListContext),
            child: Container(
                margin: const EdgeInsets.only(top: 10),
                child:
                    WidgetTransition(initialChild: gloveWidget, duration: 200)))
      ],
    );
  }
}
