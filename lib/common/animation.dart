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
