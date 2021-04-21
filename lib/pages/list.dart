///首页列表页面
///
///本页：获取列表状态并渲染；打卡；
///副作用：打卡
///
///关联路由页：详情
///
///使用组件：
///
///
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../states/target.dart';
import '../common/util.dart';
import '../components/text.dart';

class TargetList extends StatefulWidget {
  @override
  _TargetListState createState() => new _TargetListState();
}

class _TargetListState extends State<TargetList> {
  @override
  Widget build(BuildContext context) {
    /// `read` 是为了签到后不刷新全局，仅刷新目标任务组件
    final targetListContext = context.read<TargetListStates>();

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              // TODO: 根据日期切换图片
              image: AssetImage("imgs/bg/1.jpeg"),
              fit: BoxFit.cover)),
      width: double.infinity,
      child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: targetListContext.taskList
              .map((target) => FractionallySizedBox(
                    widthFactor: 1,
                    // heightFactor: 0.33,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 50, 30, 50),
                      child: TargetInfoBox(target),
                    ),
                  ))
              .toList()),
    );
  }
}

/// 任务详情组件
class TargetInfoBox extends StatelessWidget {
  final Target targetContext;
  TargetInfoBox(this.targetContext);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        //阴影
        BoxShadow(
            color: Colors.black54, offset: Offset(0.0, 2.0), blurRadius: 8.0)
      ]),
      child: Row(mainAxisSize: MainAxisSize.max, children: [
        TargetInfoRedFlag(targetContext),
        Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(color: Utils.transStr('0b1632')),
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                child: Flex(direction: Axis.horizontal, children: [
                  Expanded(flex: 3, child: TargetInfoText(targetContext)),
                  Expanded(
                      flex: 1,
                      child: FractionallySizedBox(
                        widthFactor: .7,
                        child: Image(image: AssetImage("imgs/rist.png")),
                      ))
                ]),
              ),
            ))
      ]),
    );
  }
}

// ],
/// 左边状态标识
class TargetInfoRedFlag extends StatelessWidget {
  final Target targetContext;
  TargetInfoRedFlag(this.targetContext);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.red
          // Utils.getPercentColor(targetContext.finish, targetContext.days)
          ),
      width: 10,
    );
  }
}

/// 文字包装
class TargetInfoText extends StatelessWidget {
  final Target targetContext;
  TargetInfoText(this.targetContext);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MainText(targetContext.title),
          TargetInfoSubText(targetContext)
        ]);
  }
}

class TargetInfoSubText extends StatelessWidget {
  final Target targetContext;
  TargetInfoSubText(this.targetContext);

  @override
  Widget build(BuildContext context) {
    String content =
        targetContext.finish.toString() + '/' + targetContext.days.toString();
    return StyleText(
        content,
        TextStyle(
          color: Utils.transStr(color_normal),
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ));
  }
}
