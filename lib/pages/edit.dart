import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../states/target.dart';
import '../common/util.dart';
import '../components/text.dart';
import '../common/constant.dart';

class EditTarget extends StatefulWidget {
  final Target target;
  EditTarget({this.target});

  @override
  _EditTargetState createState() => new _EditTargetState();
}

class _EditTargetState extends State<EditTarget> {
  TextEditingController _utaskController = TextEditingController();
  TextEditingController _udaysController = TextEditingController();
  Widget child;
  String toastText = '';

  bool status = false;

  void submit(TargetListStates contextStates) {
    if (status == true) {
      contextStates.edit(widget.target, _utaskController.text,
          int.parse(_udaysController.text.toString()));

      _utaskController.clear();
      _udaysController.clear();
      if (widget.target.status != statusList['finish']) {
        Navigator.pop(context, widget.target);
      }
    } else {
      Utils.showCommonToast('请填写必要字段', Utils.transStr(Constants.colorError));
    }
  }

  void onTaskChange(String days) {
    checkValid();
  }

  void onDaysChange(String days) {
    if (days != null && days != '') {
      var inputDays = int.parse(days.toString());
      if (inputDays > 365) {
        _udaysController.value = TextEditingValue(text: '365');
      }
      if (inputDays <= widget.target.finishHistory.length) {
        _udaysController.value = TextEditingValue(
            text: (widget.target.finishHistory.length + 1).toString());
      }
    }
    checkValid();
  }

  void checkValid() {
    status = _utaskController.text != '' && _udaysController.text != '';
  }

  @override
  void initState() {
    super.initState();
    toastText = '修改成功！';
    _utaskController.text = widget.target.title;
    _udaysController.text = widget.target.days.toString();
    checkValid();
  }

  Color getColor(Set<MaterialState> states) {
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('imgs/glove.webp'), context);
    final targetListContext = context.watch<TargetListStates>();

    return Scaffold(
        body: Container(
            color: Utils.transStr('000'),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                        child: Image(
                            image: AssetImage('imgs/edit.webp'),
                            repeat: ImageRepeat.noRepeat,
                            fit: BoxFit.contain))),
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
                              formatter: [
                                WhitelistingTextInputFormatter(RegExp("[0-9]"))
                              ]),
                          Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: ElevatedButton(
                                child: StyleText(
                                  '提交',
                                  TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            getColor)),
                                onPressed: () {
                                  submit(targetListContext);
                                },
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
