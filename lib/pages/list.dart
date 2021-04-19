import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../states/target.dart';

class TargetList extends StatefulWidget {
  @override
  _TargetListState createState() => new _TargetListState();
}

class _TargetListState extends State<TargetList> {
  @override
  Widget build(BuildContext context) {
    return Text('${context.watch<Target>().config['title']}');
  }
}
