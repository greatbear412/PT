import '../components.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyScroll extends StatelessWidget {
  final String wow = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new DecoratedBox(
          decoration: BoxDecoration(color: Colors.white38),
          // child: CupertinoScrollbar(
          child: new Column(
            children: [
              ListTile(
                  title: Text(
                '我是Title',
              )),
              Expanded(
                  child: new DecoratedBox(
                decoration: BoxDecoration(color: Colors.black12),
                child: ListView.builder(
                    itemCount: 7,
                    itemExtent: 30.0, //强制高度为50.0
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(title: Text("$index"));
                    }),
              ))
            ],
          )),
    );
  }
}

class MyInfiniteScroll extends StatefulWidget {
  final title = 'MyScroll';
  @override
  _MyInfiniteScrollState createState() => _MyInfiniteScrollState(title);
}

class _MyInfiniteScrollState extends State {
  final String title;
  static const loadingTag = "##loading##";
  var _words = [loadingTag];

  var insertWords = <String>[];
  final singleCount = 10;

  _MyInfiniteScrollState(this.title);
  @override
  void initState() {
    super.initState();
    _initInsertWords();
    _retrieveData();
  }

  void _initInsertWords() {
    for (var i = 0; i < singleCount; i++) {
      insertWords.add('Index: ' + i.toString());
    }
  }

  void _retrieveData() {
    Future.delayed(Duration(seconds: 2)).then((e) {
      setState(() {
        _words.insertAll(_words.length - 1, insertWords);
      });
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: MyAppBar(this.title),
      body: Scrollbar(
        child: ListView.separated(
            itemCount: _words.length,
            itemBuilder: (context, index) {
              //如果到了表尾
              if (_words[index] == loadingTag) {
                //不足100条，继续获取数据
                if (_words.length - 1 < 30) {
                  //获取数据
                  _retrieveData();
                  //加载时显示loading
                  return Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: CircularProgressIndicator(strokeWidth: 2.0)),
                  );
                } else {
                  //已经加载了100条数据，不再获取数据。
                  return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "没有更多了",
                        style: TextStyle(color: Colors.grey),
                      ));
                }
              } else {
                //显示单词列表项
                return ListTile(title: Text(_words[index]));
              }
            },
            separatorBuilder: (context, index) => Divider(height: .0)),
      ),
    );
  }
}
