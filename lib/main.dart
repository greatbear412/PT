import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'states/target.dart';
import './pages/start.dart';

import './common/constant.dart';

SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  var taskListJson = (prefs.getString('PTList') ?? '{"data": []}');
  var taskListMap = json.decode(taskListJson);
  if (taskListMap == null) {
    taskListMap = {"data": []};
  }

  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => TargetListStates.fromJson(taskListMap))
      ],
      child: MyApp(),
    ),
  );

  if (Platform.isAndroid) {
    //设置Android头部的导航栏透明
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(NetworkImage(Constants.bgUrl), context);
    return GestureDetector(
        onTap: () {
          WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
        },
        child: OKToast(
            child: MaterialApp(
                theme: ThemeData(backgroundColor: Colors.white),
                home: Start())));
  }
}
