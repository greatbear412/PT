import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

import 'common/util.dart';
import 'common/constant.dart';
import 'pages/list.dart';
import 'pages/create.dart';
import 'pages/management.dart';

class GMenu extends StatefulWidget {
  final int initialIndex;
  GMenu({this.initialIndex = 0});

  @override
  _GMenuState createState() => _GMenuState();
}

class _GMenuState extends State<GMenu> {
  int _selectedIndex;
  static List<Widget> _widgetOptions = <Widget>[
    TargetList(),
    CreateTarget(),
    Management(),
  ];

  @override
  void initState() {
    this._selectedIndex = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300],
              hoverColor: Colors.grey[100],
              gap: 8,
              activeColor: Utils.transStr(Constants.colorMain),
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.white,
              color: CupertinoColors.systemGrey,
              tabs: [
                GButton(
                  icon: CupertinoIcons.checkmark_seal_fill,
                  text: '任务',
                  iconActiveColor: Utils.transStr(Constants.colorMain),
                ),
                GButton(
                  icon: CupertinoIcons.add,
                  iconActiveColor: Utils.transStr(Constants.colorActive),
                  iconColor: Utils.transStr(Constants.colorActive),
                  textColor: Utils.transStr(Constants.colorActive),
                  text: 'Fight!',
                ),
                GButton(
                  icon: CupertinoIcons.square_list_fill,
                  text: '管理',
                  iconActiveColor: Utils.transStr(Constants.colorMain),
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
