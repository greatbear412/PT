import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';

import '../common/constant.dart';
import '../states/target.dart';
import '../common/util.dart';
import '../components/text.dart';
import './detail.dart';

class Management extends StatefulWidget {
  @override
  _ManagementState createState() => new _ManagementState();
}

class _ManagementState extends State<Management> {
  @override
  Widget build(BuildContext context) {
    final targetListContext = context.watch<TargetListStates>();
    final List<Target> allList =
        targetListContext.getTargetList().reversed.toList();
    var child = allList.length == 0
        ? Center(
            child: MainText('暂无任务。'),
          )
        : TargetListView(allList);
    return Container(
        color: Utils.transStr('000'),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: 30,
                child: Image(
                    image: AssetImage('imgs/management.webp'),
                    repeat: ImageRepeat.noRepeat,
                    width: Utils.getScreenWidth(context) * 0.5)),
            Positioned(
                top: Utils.getScreenWidth(context) * 0.6,
                bottom: 36,
                left: 0,
                right: 0,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                  child: child,
                ))
          ],
        ));
  }
}

class TargetListView extends StatelessWidget {
  final List<Target> list;
  TargetListView(this.list);

  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(10.0),
        reverse: false,
        primary: true,
        itemExtent: 110.0,
        shrinkWrap: true,
        itemCount: list.length,
        cacheExtent: 30.0,
        physics: new ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          Target target = list[index];
          // arrow_up_bin_fill
          var subText = '始于 ' + Utils.getFormatDate(target.startTime);
          var percentage = ((target.finishHistory.length / target.days) * 100)
                  .floor()
                  .toString() +
              '%';
          IconData _icon;
          Color _status_color;
          switch (target.status) {
            case 1:
              _icon = CupertinoIcons.bolt_circle_fill;
              _status_color = Utils.transStr(Constants.colorGood);
              break;
            case 2:
              _icon = CupertinoIcons.xmark_seal_fill;
              _status_color = Utils.transStr(Constants.colorError);
              break;
            case 3:
              _icon = CupertinoIcons.trash_circle_fill;
              _status_color = Utils.transStr(Constants.colorMain);
              break;
            case 99:
              _icon = CupertinoIcons.checkmark_alt_circle_fill;
              _status_color = Utils.transStr(Constants.colorSuccess);
              break;
            default:
              _icon = CupertinoIcons.bolt;
              _status_color = Utils.transStr(Constants.colorGood);
          }
          return new Listener(
              onPointerDown: (PointerDownEvent event) => pushNewScreen(context,
                  screen: Detail(target), withNavBar: false),
              child: Container(
                width: Utils.getScreenWidth(context) - 50,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                decoration: BoxDecoration(
                  color: _status_color.withOpacity(.5),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  boxShadow: [
                    //阴影
                    BoxShadow(
                        color: _status_color.withOpacity(.5),
                        offset: Offset(0.0, 4.0),
                        blurRadius: 5.0)
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      _icon,
                      size: 50,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StyleText(
                              target.title,
                              TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              lines: 1,
                              align: TextAlign.start,
                            ),
                            StyleText(
                              subText,
                              TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              lines: 1,
                            ),
                          ],
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    StyleText(
                      percentage,
                      TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      lines: 1,
                      align: TextAlign.center,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ));
        });
  }
}
