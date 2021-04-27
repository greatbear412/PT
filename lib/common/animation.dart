import 'package:flutter/material.dart';

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
  WidgetTransition({this.initialChild, this.duration});

  final Widget initialChild;
  final int duration;

// TODO: class method
  void transferTo(Widget newChild) {
    _WidgetTransitionState.transferTo(newChild);
  }

  @override
  _WidgetTransitionState createState() => _WidgetTransitionState();
}

class _WidgetTransitionState extends State<WidgetTransition> {
  Widget _child;
  Widget _oldChild;

  void transferTo(Widget newChild) {
    setState(() {
      _child = AnimatedOpacity(
          opacity: 0,
          duration: Duration(milliseconds: widget.duration),
          child: _oldChild);
      Future.delayed(Duration(milliseconds: widget.duration)).then((_) {
        _child = AnimatedOpacity(
            opacity: 1,
            duration: Duration(milliseconds: widget.duration),
            child: newChild);
        _oldChild = newChild;
      });
    });
  }

  @override
  void initState() {
    _child = widget.initialChild;
    _oldChild = _child;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _child;
  }
}
