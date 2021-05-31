import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import 'create.dart';

class TestW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 使用普通的白色 AppBar
      appBar: AppBar(
          title: Text(
            'Home',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white),
      body: TestWidget(
        child: TestChildWidget(),
      ),
    );
  }
}

// class TabRowItem extends StatelessWidget {
//   final Color color;
//   final String colorName;
//   TabRowItem({this.color, this.colorName});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Container(child: Text(abc),),);
//   }
// }

class TestWidget extends StatefulWidget {
  final Widget child;
  TestWidget({this.child});

  @override
  TestWidgetState createState() => TestWidgetState();
}

class TestWidgetState extends State<TestWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    print('Parent rebuild');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text('button:' + this.count.toString()),
        onPressed: () {
          // setState(() {
          //   count++;
          // });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => CreateTarget()));
        },
      ),
      body: Container(child: widget.child),
    );
  }
}

class TestChildWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('child rebuild');
    return Text('abc');
  }
}
