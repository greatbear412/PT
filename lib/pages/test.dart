import 'dart:ui';
import 'package:flutter/material.dart';

import '../components/text.dart';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/text.dart';

class Test extends StatelessWidget {
  TextEditingController _udaysController = TextEditingController();

  void onDaysChange(String days) {
    print(days);
  }

  @override
  Widget build(BuildContext context) {
    print('qweqwe');
    return Scaffold(
        body: Container(
      child: TextFieldWidget(
          controller: _udaysController,
          keyboardType: TextInputType.number,
          labelText: "期限(最大365)",
          style: TextStyle(color: Colors.white),
          onChange: onDaysChange,
          formatter: [WhitelistingTextInputFormatter(RegExp("[0-9]"))]),
    ));
  }
}
