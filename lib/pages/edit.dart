import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/constant.dart';
import '../states/target.dart';
import '../common/util.dart';
import '../components/text.dart';

class EditTarget extends StatefulWidget {
  @override
  _EditTargetState createState() => new _EditTargetState();
}

class _EditTargetState extends State<EditTarget> {
  TextEditingController _utaskController = TextEditingController();
  TextEditingController _udaysController = TextEditingController();

  void createTarget(TargetListStates contextStates) {
    contextStates.create(
        _utaskController.text, int.parse(_udaysController.text.toString()));
    Future.delayed(Duration(seconds: 0)).then((_) {
      Navigator.pushNamed(context, "target_list_or_start");
    });
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

  void checkValid() {}

  @override
  Widget build(BuildContext context) {
    final targetListContext = context.watch<TargetListStates>();
    return Container(
        color: Utils.transStr('000'),
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Center(
                    child: Image(
                  image: AssetImage('imgs/edit.png'),
                  repeat: ImageRepeat.noRepeat,
                  width: MediaQuery.of(context).size.width * 1,
                ))),
            Container(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  // height: 200,
                  color: Colors.black.withOpacity(0.3),
                  // padding: const EdgeInsets.only(bottom: 100),
                  alignment: Alignment.center,
                  child: Column(
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
                      ),
                      Listener(
                          onPointerDown: (PointerDownEvent event) =>
                              createTarget(targetListContext),
                          child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Image(
                                image: AssetImage('imgs/glove.webp'),
                                repeat: ImageRepeat.noRepeat,
                                width: 100,
                              )))
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
