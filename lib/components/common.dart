import 'package:flutter/material.dart';

class CommonPosition extends StatelessWidget {
  final Widget child;
  CommonPosition(this.child);
  @override
  Widget build(BuildContext context) {
    return Positioned(left: 0, right: 0, top: 0, bottom: 0, child: child);
  }
}
