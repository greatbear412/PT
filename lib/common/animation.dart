import 'package:flutter/material.dart';
import 'dart:async';
import './bus.dart';

class AnimatedImage extends AnimatedWidget {
  final String imgSrc = '';
  AnimatedImage({Key key, Animation<double> animation, String imgSrc})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
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
          return new Container(
              height: animation.value, width: animation.value, child: child);
        },
        child: child);
  }
}

class WidgetTransition extends StatefulWidget {
  WidgetTransition({this.initialChild, this.duration, Key key})
      : super(key: key);

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
