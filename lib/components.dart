import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  final String _title;

  MyAppBar(this._title);

  Widget build(BuildContext context) {
    return AppBar(
      title: Text(this._title ?? 'qwe'),
    );
  }
}
