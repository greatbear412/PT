import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StyleText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final int lines;
  StyleText(this.text, this.style, {this.lines = 1});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      maxLines: lines,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class MainText extends StatelessWidget {
  final String text;
  final int lines;
  MainText(this.text, {this.lines = 1});

  @override
  Widget build(BuildContext context) {
    return StyleText(
        text,
        TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        lines: lines);
  }
}
