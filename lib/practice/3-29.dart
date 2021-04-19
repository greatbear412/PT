import 'package:flutter/material.dart';

import '../components.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Theme(
            data: Theme.of(context).copyWith(
                hintColor: Colors.grey[200], //定义下划线颜色
                inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.grey), //定义label字体样式
                    hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 14.0) //定义提示文本样式
                    )),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      labelText: "用户名",
                      hintText: "用户名或邮箱",
                      prefixIcon: Icon(Icons.person)),
                ),
                TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "密码",
                      hintText: "您的登录密码",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 13.0)),
                  obscureText: true,
                )
              ],
            )));
  }
}

class RowStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: MyAppBar('RowStart'),
        body: Column(
          //测试Row对齐方式，排除Column默认居中对齐的干扰
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(" T1 "),
                Text(" T1 "),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(" T2 "),
                Text(" T2 "),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Text(" T3 "),
                Text(" T3 "),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                Text(
                  " T4444 ",
                  style: TextStyle(fontSize: 30.0),
                ),
                Text(" T44444 "),
              ],
            ),
          ],
        ));
  }
}
