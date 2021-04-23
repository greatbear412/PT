import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => new _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () {
      Navigator.pushNamed(context, "target_list_or_start");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('1123'),
    );
  }
}
