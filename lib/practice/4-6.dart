import '../components.dart';

import 'package:flutter/material.dart';

Future<String> mockNetworkData() async {
  return Future.delayed(Duration(seconds: 2), () => "我是从互联网上获取的数据");
}

class MyAsyncUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: MyAppBar('RowStart'),
        body: Center(
          child: FutureBuilder<String>(
            future: mockNetworkData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // 请求已结束
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  // 请求失败，显示错误
                  return Text("Error: ${snapshot.error}");
                } else {
                  // 请求成功，显示数据
                  return Text("Contents: ${snapshot.data}");
                }
              } else {
                // 请求未结束，显示loading
                return CircularProgressIndicator();
              }
            },
          ),
        ));
  }
}

Stream<int> counter() {
  return Stream.periodic(Duration(seconds: 1), (i) {
    return i;
  });
}

class MyAsyncUiStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: MyAppBar('RowStart'),
        body: Center(
            child: StreamBuilder<int>(
                stream: counter(), //
                //initialData: ,// a Stream<int> or null
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('没有Stream');
                    case ConnectionState.waiting:
                      return Text('等待数据...');
                    case ConnectionState.active:
                      return Text('active: ${snapshot.data}');
                    case ConnectionState.done:
                      return Text('Stream已关闭');
                  }
                  return null; // unreachable
                })));
  }
}

class MyDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<bool> showDeleteConfirmDialog1() {
      return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("您确定要删除当前文件吗?"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(), // 关闭对话框
              ),
              FlatButton(
                child: Text("删除"),
                onPressed: () {
                  //关闭对话框并返回true
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      );
    }

    Future<int> showListDialog() {
      return showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          var child = Column(
            children: <Widget>[
              ListTile(title: Text("请选择")),
              Expanded(
                  child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text("$index"),
                    onTap: () => Navigator.of(context).pop(index),
                  );
                },
              )),
            ],
          );
          //使用AlertDialog会报错
          //return AlertDialog(content: child);
          // return Dialog(child: child);
          return UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 280),
              child: Material(
                child: child,
                type: MaterialType.card,
              ),
            ),
          );
        },
      );
    }

    return new Scaffold(
        appBar: MyAppBar('MyDialog'),
        body: Center(
          child: RaisedButton(
            child: Text("对话框1"),
            onPressed: () async {
              //弹出对话框并等待其关闭
              // bool delete = await showDeleteConfirmDialog1();
              // if (delete == null) {
              //   print("取消删除");
              // } else {
              //   print("已确认删除");
              //   //... 删除文件
              // }
              //
              //
              // var index = await showListDialog();
              // if (index != null) {
              //   print("点击了：$index");
              // }
              //
              //
              // var rlt = await showCustomDialog<bool>(
              //   context: context,
              //   builder: (context) {
              //     return AlertDialog(
              //       title: Text("提示"),
              //       content: Text("您确定要删除当前文件吗?"),
              //       actions: <Widget>[
              //         FlatButton(
              //           child: Text("取消"),
              //           onPressed: () => Navigator.of(context).pop(),
              //         ),
              //         FlatButton(
              //           child: Text("删除"),
              //           onPressed: () {
              //             // 执行删除操作
              //             Navigator.of(context).pop(true);
              //           },
              //         ),
              //       ],
              //     );
              //   },
              // );
              //
              var rlt = await showDeleteConfirmDialog4(context);
              print("点击了：$rlt");
            },
          ),
        ));
  }
}

Future<T> showCustomDialog<T>({
  @required BuildContext context,
  bool barrierDismissible = true,
  WidgetBuilder builder,
}) {
  final ThemeData theme = Theme.of(context);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black87, // 自定义遮罩颜色
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  // 使用缩放动画
  return ScaleTransition(
    scale: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}

class Builder extends StatelessWidget {
  const Builder({
    Key key,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) => builder(context);
}

class MyStateFulBuilder extends StatefulWidget {
  const MyStateFulBuilder({
    Key key,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);
  final WidgetBuilder builder;

  _MyStateFulBuilderState createState() {
    return new _MyStateFulBuilderState(builder);
  }
}

class _MyStateFulBuilderState extends State<MyStateFulBuilder> {
  _MyStateFulBuilderState(this.builder);
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) => builder(context);
}

Future<bool> showDeleteConfirmDialog4(context) {
  bool _withTree = true;
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("提示"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("您确定要删除当前文件吗?"),
            Row(
              children: <Widget>[
                Text("同时删除子目录？"),
                Checkbox(
                  // 依然使用Checkbox组件
                  value: _withTree,
                  onChanged: (bool value) {
                    // 此时context为对话框UI的根Element，我们
                    // 直接将对话框UI对应的Element标记为dirty
                    // (context as Element).markNeedsBuild();
                    _withTree = !_withTree;
                  },
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("取消"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text("删除"),
            onPressed: () {
              // 执行删除操作
              Navigator.of(context).pop(_withTree);
            },
          ),
        ],
      );
    },
  );
}
