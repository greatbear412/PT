import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

import '../common/constant.dart';
import '../states/target.dart';
import '../common/util.dart';
import '../components/text.dart';
import './edit.dart';

class Detail extends StatefulWidget {
  final Target target;
  Detail(this.target);

  @override
  _DetailState createState() => new _DetailState(target);
}

class _DetailState extends State<Detail> {
  final Target target;
  _DetailState(this.target);

  Widget getFinishCalendarItem(String day) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: ClipOval(
          child: Container(
        color: Utils.transStr(Constants.colorSuccess),
        child: Center(
          child: StyleText(
            day,
            TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      )),
    );
  }

  Widget getWeekendItem(String day) {
    return Center(
      child: Text(
        day,
        style: TextStyle(color: Utils.transStr('fe6f44')),
      ),
    );
  }

  Widget getBtns(String text, String imgSrc, Color color, Function callback,
      {Target target, TargetListStates targetListStates}) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Utils.transStr(Constants.colorActive);
      }
      return color;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child:
                Image(image: AssetImage(imgSrc), repeat: ImageRepeat.noRepeat)),
        ElevatedButton(
          child: StyleText(
            text,
            TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(getColor)),
          onPressed: () {
            if (targetListStates != null) {
              callback(target, targetListStates);
            } else {
              callback(target);
            }
          },
        )
      ],
    );
  }

  void goEdit(Target target) async {
    var newTarget = await pushNewScreen(context,
        screen: EditTarget(target: target), withNavBar: false);
    setState(() {
      target = newTarget;
    });
  }

  void goReStart(Target target, TargetListStates targetListStates) {
    final List<Target> targetListRunning =
        targetListStates.getTargetList(status: 'running');
    if (targetListRunning.length < 3) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Readay?'),
              content: Text('准备好了么？'),
              actions: <Widget>[
                FlatButton(
                  child: Text('开始吧。'),
                  onPressed: () {
                    targetListStates.reStart(target);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    } else {
      Utils.showCommonToast(
          '目前任务已经够3个了', Utils.transStr(Constants.colorWarning));
    }
  }

  void goAbolish(Target target, TargetListStates targetListStates) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Really?'),
            content: Text('确认放弃吗？'),
            actions: <Widget>[
              FlatButton(
                child: Text('放弃吧。'),
                onPressed: () {
                  targetListStates.abolish(target);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    IconData _icon;
    Color _status_color;
    final targetListContext = context.watch<TargetListStates>();

    Widget btnEdit = getBtns(
        '编辑', 'imgs/edit_target.webp', Utils.transStr('fbd9ce'), goEdit,
        target: target);
    Widget btnReStart = getBtns(
        '重来', 'imgs/restart.webp', Utils.transStr('50f359'), goReStart,
        target: target, targetListStates: targetListContext);
    Widget btnAbolish = getBtns(
        '放弃', 'imgs/abondon.webp', Utils.transStr('ebf1da'), goAbolish,
        target: target, targetListStates: targetListContext);
    List<Widget> btnGroups = [btnEdit, btnReStart, btnAbolish];

    switch (target.status) {
      case 1:
        _icon = CupertinoIcons.bolt_circle_fill;
        _status_color = Utils.transStr(Constants.colorGood);
        btnGroups.removeAt(1);
        break;
      case 2:
        _icon = CupertinoIcons.xmark_seal_fill;
        _status_color = Utils.transStr(Constants.colorError);
        btnGroups = [btnReStart];
        break;
      case 3:
        _icon = CupertinoIcons.trash_circle_fill;
        _status_color = Utils.transStr(Constants.colorMain);
        btnGroups = [btnReStart];
        break;
      case 99:
        _icon = CupertinoIcons.checkmark_alt_circle_fill;
        _status_color = Utils.transStr(Constants.colorSuccess);
        btnGroups = [btnReStart];
        break;
      default:
        _icon = CupertinoIcons.bolt;
        _status_color = Utils.transStr(Constants.colorGood);
        btnGroups.removeAt(1);
    }

    var subText = '始于 ' + Utils.getFormatDate(target.startTime);
    return Scaffold(
        body: Container(
            color: Colors.white,
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
                Positioned(
                  top: 0,
                  bottom: 10,
                  left: 20,
                  right: 20,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TableCalendar(
                          firstDay: target.startTime,
                          lastDay: DateTime.now(),
                          focusedDay: DateTime.now(),
                          availableCalendarFormats: {
                            CalendarFormat.month: 'Month'
                          },
                          calendarBuilders: CalendarBuilders(
                              defaultBuilder: (context, day, _) {
                            if (target.finishHistory
                                .contains(Utils.getFormatDate(day))) {
                              return getFinishCalendarItem(day.day.toString());
                            } else if (Utils.isWeekend(day)) {
                              return getWeekendItem(day.day.toString());
                            }
                          }, todayBuilder: (context, day, _) {
                            if (target.finishToday) {
                              return getFinishCalendarItem(day.day.toString());
                            }
                          }, dowBuilder: (context, day) {
                            if (Utils.isWeekend(day)) {
                              return getWeekendItem(day.day.toString());
                            }
                          }),
                        ),
                        SizedBox(
                          height: 80,
                          child: Row(
                            children: [
                              Icon(
                                _icon,
                                size: 50,
                                color: _status_color,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              StyleText(
                                target.title,
                                TextStyle(
                                  color: _status_color,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(CupertinoIcons.percent),
                              StyleText(
                                ((target.finishHistory.length / target.days) *
                                        100)
                                    .floor()
                                    .toString(),
                                TextStyle(
                                  // color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              StyleText(
                                '完成度：' +
                                    target.finishHistory.length.toString() +
                                    '/' +
                                    target.days.toString(),
                                TextStyle(
                                  // color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        StyleText(
                          subText,
                          TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: btnGroups,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
