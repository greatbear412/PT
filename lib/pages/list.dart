/// 四种状态：
/// 1. 没有任务；
/// 2.有任务：正在进行中
/// 3.有任务：全部完成
/// 4.有任务：没有有效的
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/constant.dart';
import '../states/target.dart';
import '../common/util.dart';
import '../components/text.dart';
import '../components/common.dart';

class TargetList extends StatefulWidget {
  @override
  _TargetListState createState() => new _TargetListState();
}

class _TargetListState extends State<TargetList> {
  Widget tlContainer = Container();
  @override
  Widget build(BuildContext context) {
    final targetListContext = context.watch<TargetListStates>();
    final List<Target> targetListRunning =
        targetListContext.getTargetList(status: 'running');
    final List<Target> targetListAll = targetListContext.getTargetList();

    // 还有进行中的
    if (targetListRunning.any((Target target) => target.finishToday == false)) {
      tlContainer = Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: Flex(
            clipBehavior: Clip.hardEdge,
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: targetListRunning
                .map((target) => Flexible(
                      fit: FlexFit.loose,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(30, 50, 30, 50),
                        child: TargetInfoBox(target, targetListContext),
                      ),
                    ))
                .toList()),
      );
    } else {
      String content = '';
      String statusColor;
      if (targetListAll.length == 0) {
        content = '先去创建个任务吧。';
        statusColor = Constants.colorWarning;
      } else if (targetListRunning.length > 0) {
        content = '很好！今天全部完成了。';
        statusColor = Constants.colorSuccess;
      } else {
        content = '没有有效的任务了。';
        statusColor = Constants.colorError;
      }
      // 没有进行中的
      tlContainer = Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 50),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
                decoration: BoxDecoration(
                    color: Utils.transStr(statusColor, alpha: 200)),
                padding: EdgeInsets.all(10),
                child: StyleText(
                    content,
                    TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ))),
          ));
    }
    return Container(
        child: Stack(children: [
      CommonPosition(Container(
        color: Utils.transStr(Constants.colorPandaBG),
        child: FadeInImage(
          placeholder: AssetImage('imgs/panda.webp'),
          image: NetworkImage(Constants.bgUrl),
          fit: BoxFit.cover,
        ),
      )),
      CommonPosition(tlContainer)
    ]));
  }
}

/// 任务详情组件
class TargetInfoBox extends StatelessWidget {
  final Target targetContext;
  final TargetListStates targetListContext;
  TargetInfoBox(this.targetContext, this.targetListContext);

  @override
  Widget build(BuildContext context) {
    List<Widget> wgChild;
    // 已完成
    if (targetContext.finishToday) {
      var content = targetContext.title +
          '(' +
          targetContext.finishHistory.length.toString() +
          '/' +
          targetContext.days.toString() +
          ')';
      wgChild = [
        SizedBox(
          width: 20,
        ),
        Expanded(
            flex: 3,
            child: StyleText(
                content,
                TextStyle(
                  color: Colors.grey,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.lineThrough,
                ),
                lines: 1))
      ];
    } else {
      wgChild = [
        SizedBox(
          width: 20,
        ),
        Expanded(flex: 3, child: TargetInfoText(targetContext)),
        Expanded(
            flex: 1, child: TargetInfoSign(targetContext, targetListContext))
      ];
    }
    return Container(
        decoration: BoxDecoration(boxShadow: [
          //阴影
          BoxShadow(
              color: Colors.black54, offset: Offset(0.0, 4.0), blurRadius: 5.0)
        ], borderRadius: BorderRadius.all(Radius.circular(16.0))),
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minWidth: double.infinity, maxHeight: 120.0),
          child: Container(
              child: Row(mainAxisSize: MainAxisSize.max, children: [
            // TargetInfoRedFlag(targetContext),
            Expanded(
                flex: 1,
                child: Container(
                  decoration:
                      // 信息板背景
                      BoxDecoration(
                          color: Utils.transStr(Constants.colorMain)
                              .withOpacity(.6),
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                    child: Flex(direction: Axis.horizontal, children: wgChild),
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
          color: Utils.getPercentColor(
              targetContext.finishHistory.length, targetContext.days)),
      width: 10,
    );
  }
}

/// 任务标题
class TargetInfoText extends StatelessWidget {
  final Target targetContext;
  TargetInfoText(this.targetContext);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          MainText(targetContext.title),
        ]);
  }
}

// 签到按钮
class TargetInfoSign extends StatefulWidget {
  final Target targetContext;
  final TargetListStates targetListContext;
  TargetInfoSign(this.targetContext, this.targetListContext);

  @override
  _TargetInfoSignState createState() => new _TargetInfoSignState();
}

class _TargetInfoSignState extends State<TargetInfoSign>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  final int dur = 500;
  final double widthFactorStart = 0.5;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: Duration(milliseconds: dur), vsync: this);
    //图片宽高从0变到300
    animation =
        new Tween(begin: widthFactorStart, end: 1.0).animate(controller);
  }

  bool signIn() {
    //启动动画
    controller.forward();

    Future.delayed(Duration(milliseconds: dur)).then((_) {
      widget.targetListContext.sign(widget.targetContext);
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    const String imgSrc = "imgs/fist.webp";
    var imgWidget = Image(image: AssetImage(imgSrc));

    return Listener(
      child: Stack(
        children: [
          CommonPosition(FractionallySizedBox(
              widthFactor: widthFactorStart, child: imgWidget)),
          CommonPosition(AnimatedFist(animation: animation)),
        ],
      ),
      onPointerDown: (PointerDownEvent event) => signIn(),
    );
  }

  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

class TargetInfoRecord extends StatefulWidget {
  final Target targetContext;
  final TargetListStates targetListContext;
  TargetInfoRecord(this.targetContext, this.targetListContext);

  @override
  _TargetInfoRecordState createState() => new _TargetInfoRecordState();
}

class _TargetInfoRecordState extends State<TargetInfoRecord> {
  final double widthFactorStart = 0.5;

  bool writeRecord() {
    widget.targetListContext.sign(widget.targetContext);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    const String imgSrc = "imgs/fist.webp";
    var imgWidget = Image(image: AssetImage(imgSrc));

    return Listener(
      child: Stack(
        children: [
          CommonPosition(FractionallySizedBox(
              widthFactor: widthFactorStart, child: imgWidget)),
        ],
      ),
      onPointerDown: (PointerDownEvent event) => writeRecord(),
    );
  }
}

class AnimatedFist extends AnimatedWidget {
  AnimatedFist({Animation<double> animation}) : super(listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new FractionallySizedBox(
        widthFactor: animation.value,
        child: Opacity(
            opacity: 0.5, child: Image(image: AssetImage("imgs/fist.webp"))));
  }
}
