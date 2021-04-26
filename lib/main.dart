import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'states/target.dart';

import 'pages/list.dart';
import 'pages/start.dart';
import 'pages/edit.dart';
import 'pages/detail.dart';

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TargetListStates()),
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
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final targetListContext = context.watch<TargetListStates>();
    return MaterialApp(
        theme: ThemeData(backgroundColor: Colors.white),
        initialRoute: "/",
        onGenerateRoute: (RouteSettings settings) {
          String routeName = settings.name;
          final List<Target> validTargetList =
              targetListContext.getTargetList(status: 'running');
          var targetChild = validTargetList.length > 0 ? TargetList() : Start();
          var child;
          switch (routeName) {
            case 'edit_target':
              child = EditTarget();
              break;
            case 'detail_target':
              child = Detail(settings.arguments);
              break;
            case 'target_list_or_start':
              child = targetChild;
              break;
            default:
              child = Start();
          }
          return MaterialPageRoute(builder: (context) {
            return Scaffold(body: child);
          });
        });
  }
}

///这个组件用来重新加载整个child Widget的。当我们需要重启APP的时候，可以使用这个方案
///https://stackoverflow.com/questions/50115311/flutter-how-to-force-an-application-restart-in-production-mode
// class RestartWidget extends StatefulWidget {
//   final Widget child;

//   RestartWidget({Key key, @required this.child})
//       : assert(child != null),
//         super(key: key);

//   static restartApp(BuildContext context) {
//     final _RestartWidgetState state = context.findAncestorStateOfType();
//     state.restartApp();
//   }

//   @override
//   _RestartWidgetState createState() => _RestartWidgetState();
// }

// class _RestartWidgetState extends State<RestartWidget> {
//   Key key = UniqueKey();

//   void restartApp() {
//     setState(() {
//       key = UniqueKey();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       key: key,
//       child: widget.child,
//     );
//   }
// }
