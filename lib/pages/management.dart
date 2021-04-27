import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/constant.dart';
import '../states/target.dart';
import '../common/util.dart';
import '../components/text.dart';
import '../components/common.dart';

class Management extends StatefulWidget {
  @override
  _ManagementState createState() => new _ManagementState();
}

class _ManagementState extends State<Management> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('123'),
      // width: Utils.getScreenWidth(context),
      // height: Utils.getScreenHeight(context),
      // child: Column(
      //   children: [
      //     TableCalendar(
      //       firstDay: DateTime.utc(2010, 10, 16),
      //       lastDay: DateTime.now(),
      //       focusedDay: DateTime.now(),
      //     )
      //   ],
      // ),
    );
  }
}
