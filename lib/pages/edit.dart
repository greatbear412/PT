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

  @override
  Widget build(BuildContext context) {
    final targetListContext = context.watch<TargetListStates>();
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('imgs/edit.jpg'), fit: BoxFit.cover)),
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                // onPointerDown: (PointerDownEvent event) => createTarget(),
                child: Center(
                  child: Container(
                    width: 300,
                    height: 200,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        TextFieldWidget(
                            controller: _utaskController,
                            labelText: "Task",
                            hintText: "任务"),
                        TextFieldWidget(
                            controller: _udaysController,
                            labelText: "Days",
                            hintText: "期限")
                      ],
                    ),
                  ),
                ))
          ],
        ));
  }
}
