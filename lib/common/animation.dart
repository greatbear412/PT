import 'package:flutter/material.dart';
import 'dart:async';
import './bus.dart';
import 'dart:math';

class AnimatedImage extends AnimatedWidget {
  AnimatedImage(this.animation, this.imgSrc);

  final String imgSrc;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return new Center(
      child:
          Image.asset(imgSrc, width: animation.value, height: animation.value),
    );
  }
}

class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return new AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return Container(
              height: animation.value, width: animation.value, child: child);
        },
        child: child);
  }
}

class OpacityTransition extends StatefulWidget {
  final Duration duration;
  final Widget child;

  OpacityTransition({this.duration, this.child});

  @override
  OpacityTransitionState createState() => OpacityTransitionState();
}

class OpacityTransitionState extends State<OpacityTransition> {
  double opacity = 0;
  OpacityTransitionState();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0)).then((_) {
      setState(() {
        this.opacity = 1;
      });
    });
    Future.delayed(widget.duration).then((_) {
      if (mounted == true) {
        setState(() {
          this.opacity = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: this.opacity,
      duration: widget.duration,
      child: widget.child,
      curve: Curves.easeInOut,
    );
  }
}

class WidgetTransition extends StatefulWidget {
  WidgetTransition({this.initialChild, this.duration});

  final Widget initialChild;
  final int duration;

  @override
  _WidgetTransitionState createState() => _WidgetTransitionState();
}

class _WidgetTransitionState extends State<WidgetTransition> {
  Widget _child;
  Widget _oldChild;
  String _key;
  List<List> taskQueue = [];
  bool running = false;

  Timer timerInit;
  Timer timerTranstion;

  void runTransferQueue() {
    if (taskQueue.length > 0) {
      var task = taskQueue.removeAt(0);
      transfer(task[0], task[1]);
    }
  }

  void transfer(String key, Widget newChild) {
    if (_key == key && _oldChild != newChild) {
      running = true;
      timerInit = Timer(Duration.zero, () {
        setState(() {
          _child = AnimatedOpacity(
              opacity: 0,
              duration: Duration(milliseconds: widget.duration),
              child: _oldChild);
          timerTranstion = Timer(Duration(milliseconds: widget.duration), () {
            setState(() {
              _child = AnimatedOpacity(
                  opacity: 1,
                  duration: Duration(milliseconds: widget.duration),
                  child: newChild);
              _oldChild = newChild;
            });
            running = false;
            runTransferQueue();
          });
        });
      });
    } else {
      runTransferQueue();
    }
  }

  @override
  void initState() {
    _child = widget.initialChild;
    _oldChild = _child;
    bus.on("transferGlove", (arg) {
      if (_key == null) {
        _key = arg['key'];
      }
      taskQueue.add([arg['key'], arg['body']]);
      if (running == false) {
        runTransferQueue();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _child;
  }

  @override
  dispose() {
    timerInit?.cancel();
    timerTranstion?.cancel();
    bus.off("transferGlove");
    super.dispose();
  }
}

class CyberPunk extends StatefulWidget {
  final Widget child;

  /// 渐隐动画的持续时间；由于有渐显和渐隐两个阶段，所以整个动画最大持续时间为2倍 `dur`
  final int dur;
  final int cyberItemCount;
  final double maxHeight;
  final int repeatTimes;

  CyberPunk(
      {this.child,
      this.dur,
      this.maxHeight,
      this.cyberItemCount = 10,
      this.repeatTimes = 1});
  @override
  CyberPunkState createState() => CyberPunkState(
      repeatTimes: repeatTimes,
      cyberItem: ClipChild(
        child: child,
        maxHeight: maxHeight,
      ));
}

class CyberPunkState extends State<CyberPunk> {
  Random random;
  Widget cyberItem;
  int repeatTimes;

  CyberPunkState({this.cyberItem, this.repeatTimes});

  void setRepeat() {
    this.repeatTimes--;
    if (this.repeatTimes > 0) {
      Future.delayed(Duration(milliseconds: widget.dur * 2)).then((_) {
        this.setRepeat();
        this.setState(() {});
      });
    }
  }

  @override
  initState() {
    super.initState();
    this.random = new Random();
    this.setRepeat();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final List<Widget> cyberList = [];
      final width = constraints.maxWidth;
      for (var i = 0; i < widget.cyberItemCount; i++) {
        final left = this.random.nextDouble() * width - width / 2;
        final durantion = this.random.nextDouble() * widget.dur;
        cyberList.add(Positioned(
            key: Key(left.toString()),
            left: left,
            child: OpacityTransition(
                duration: Duration(milliseconds: durantion.floor()),
                child: cyberItem)));
      }
      return Stack(
        children: [widget.child, ...cyberList],
      );
    });
  }
}

class ClipChild extends StatelessWidget {
  final double maxHeight;
  final Widget child;
  ClipChild({Key key, this.child, this.maxHeight});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: child,
      clipper: RandomRectPath(10, maxHeight: this.maxHeight),
    );
  }
}

class RandomRectPath extends CustomClipper<Path> {
  /// 每一块儿的高度
  final double pieceHeight;

  /// 最大高度；不传或传0时，将取child原始高度 `size.height`
  final double maxHeight;
  final Random random = new Random();

  RandomRectPath(this.pieceHeight, {this.maxHeight = 0});

  @override
  Path getClip(Size size) {
    var height = maxHeight == 0 ? size.height : maxHeight;
    var top = random.nextDouble() * height;
    var path = Path();
    path.moveTo(0, top);
    path.lineTo(size.width, top);
    path.lineTo(size.width, top + this.pieceHeight);
    path.lineTo(0, top + this.pieceHeight);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
