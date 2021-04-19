import 'package:flutter/material.dart';

class NewRoute extends StatelessWidget {
  NewRoute(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
          child: new Column(
        children: [
          Text.rich(
              // '$text' * 55,
              // maxLines: 5,
              // textAlign: TextAlign.center,
              // overflow: TextOverflow.ellipsis,
              TextSpan(children: [TextSpan(text: ''), TextSpan(text: '')])),
          ElevatedButton(
              child: Text('test'), onPressed: () => Navigator.pop(context))
        ],
      )),
    );
  }
}
