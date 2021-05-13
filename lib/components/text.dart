import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/util.dart';

class StyleText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final int lines;
  final TextAlign align;
  StyleText(this.text, this.style,
      {this.lines = 1, this.align = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      maxLines: lines,
      softWrap: false,
      textAlign: align,
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

///文本搜索框
class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final TextStyle style;
  final void Function(String) onChange;
  final List<TextInputFormatter> formatter;

  TextFieldWidget(
      {this.labelText,
      this.hintText = '',
      this.controller,
      this.style = const TextStyle(),
      this.onChange,
      this.formatter = const [],
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: style,
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.grey[200]),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white),
            // prefixIcon: Icon(Icons.email),
            border: InputBorder.none //隐藏下划线
            ),
        onChanged: onChange,
        inputFormatters: formatter,
      ),
      decoration: BoxDecoration(
          // 下滑线浅灰色，宽度1像素
          border:
              Border(bottom: BorderSide(color: Colors.grey[200], width: 1.5))),
    );
  }
}

class QuotaText extends StatelessWidget {
  final String text;
  QuotaText({this.text});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 50),
        child: Container(
          child: Row(
            children: [
              Container(
                width: 5,
                color: Utils.transStr('f9f871'),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    CupertinoIcons.quote_bubble_fill,
                    color: Utils.transStr('f9f871'),
                  ),
                  StyleText(
                    text,
                    TextStyle(fontSize: 18, color: Utils.transStr('a39d9d')),
                    lines: 2,
                  )
                ],
              ))
            ],
          ),
        ));
  }
}
