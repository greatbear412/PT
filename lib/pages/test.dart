import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

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
      body: ListView.builder(
          itemCount: 100,
          // 为列表创建 100 个不同颜色的 RowItem
          itemBuilder: (context, index) => TabRowItem(
                color: Colors.red, // 设置不同的颜色
                colorName: 'qweqwe' + index.toString(),
              )),
    );
    ;
  }
}

class TabRowItem extends StatelessWidget {
  final Color color;
  final String colorName;
  TabRowItem({this.color, this.colorName});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 50),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                color: this.color,
              )),
          Expanded(flex: 3, child: Text(this.colorName))
        ],
      ),
    );
  }
}
