import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';

import '../states/target.dart';
import '../common/util.dart';
import '../common/bus.dart';
import '../common/animation.dart';
import '../components/text.dart';

class EditTarget extends StatefulWidget {
  @override
  _EditTargetState createState() => new _EditTargetState();
}

class _EditTargetState extends State<EditTarget> {
  TextEditingController _utaskController = TextEditingController();
  TextEditingController _udaysController = TextEditingController();
  Widget child;

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

  void createTarget(TargetListStates contextStates) {
    if (status == true) {
      contextStates.create(
          _utaskController.text, int.parse(_udaysController.text.toString()));
      _utaskController.clear();
      _udaysController.clear();
      checkValid();
      showToast("创建成功!",
          duration: Duration(seconds: 2),
          position: ToastPosition.top,
          backgroundColor: Colors.yellow.withOpacity(0.8),
          radius: 18.0,
          textStyle: TextStyle(fontSize: 24.0),
          textPadding: const EdgeInsets.fromLTRB(28, 18, 28, 18));
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
    bus.emit("transferGlove", {'key': 'edit', 'body': gloveWidget});
  }

  @override
  void initState() {
    checkValid();
    gloveWidget = errorGloveWidget;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('imgs/glove.webp'), context);
    final targetListContext = context.watch<TargetListStates>();
    final List<Target> targetListRunning =
        targetListContext.getTargetList(status: 'running');
    if (targetListRunning.length < 3) {
      child = Column(
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
                  createTarget(targetListContext),
              child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: WidgetTransition(
                    initialChild: gloveWidget,
                    duration: 500,
                  )))
        ],
      );
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
                        image: AssetImage('imgs/edit.webp'),
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
                  child: child,
                ),
              ),
            )
          ],
        ));
  }
}
