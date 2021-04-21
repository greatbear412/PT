///首页列表页面
///
///本页：获取列表状态并渲染；打卡；
///副作用：打卡
///
///关联路由页：详情
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
    final targetListContext = context.watch<TargetListStates>();
    final List<Target> targetList = targetListContext.getValidTarget();

// TODO: 依据有效任务数量渲染;是否跳转初始页
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              // TODO: 根据日期切换图片
              image: AssetImage("imgs/bg/1.jpeg"),
              fit: BoxFit.cover)),
      width: double.infinity,
      alignment: Alignment.center,
      child: Flex(
          clipBehavior: Clip.hardEdge,
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: targetList
              .map((target) => Flexible(
                    fit: FlexFit.loose,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 50, 30, 50),
                      child: TargetInfoBox(target, targetListContext),
                    ),
                  ))
              .toList()),
    );
  }
}

/// 任务详情组件
class TargetInfoBox extends StatelessWidget {
  final Target targetContext;
  final TargetListStates targetListContext;
  TargetInfoBox(this.targetContext, this.targetListContext);

// TODO: 依据状态渲染
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(boxShadow: [
          //阴影
          BoxShadow(
              color: Colors.black54, offset: Offset(0.0, 4.0), blurRadius: 12.0)
        ]),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: double.infinity, //宽度尽可能大
              maxHeight: 120.0 //最小高度为50像素
              ),
          child: Container(
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
                          child:
                              TargetInfoSign(targetContext, targetListContext))
                    ]),
                  ),
                ))
          ])),
        ));
  }
}

/// 左边状态标识
class TargetInfoRedFlag extends StatelessWidget {
  final Target targetContext;
  TargetInfoRedFlag(this.targetContext);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color:
              Utils.getPercentColor(targetContext.finish, targetContext.days)),
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

class TargetInfoSign extends StatelessWidget {
  final Target targetContext;
  final TargetListStates targetListContext;
  TargetInfoSign(this.targetContext, this.targetListContext);

  void signIn() {
    // TODO: 签到动画
    Future.delayed(Duration(milliseconds: 500)).then((_) {
      targetListContext.sign(targetContext);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: .7,
        child: Listener(
          child: Container(
            child: Image(image: AssetImage("imgs/rist.png")),
          ),
          onPointerDown: (PointerDownEvent event) => signIn(),
        ));
  }
}
