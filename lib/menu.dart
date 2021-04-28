import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'common/util.dart';
import 'common/constant.dart';

import 'pages/list.dart';
import 'pages/edit.dart';
import 'pages/management.dart';

class MainMenu extends StatefulWidget {
  final int initialIndex;
  MainMenu({this.initialIndex});

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  PersistentTabController _controller;
  bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: widget.initialIndex);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens(context) {
    return [
      MainScreen(menuScreenContext: context, child: TargetList()),
      MainScreen(menuScreenContext: context, child: EditTarget()),
      MainScreen(menuScreenContext: context, child: Management()),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.checkmark_seal_fill),
        activeColorPrimary: Utils.transStr(Constants.colorMain),
        inactiveColorPrimary: CupertinoColors.systemGrey,
        routeAndNavigatorSettings:
            RouteAndNavigatorSettings(initialRoute: '/target_list'),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.add),
        activeColorPrimary: Utils.transStr(Constants.colorActive),
        activeColorSecondary: Utils.transStr('f9f871'),
        inactiveColorPrimary: Colors.white,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/add',
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.square_list_fill),
        activeColorPrimary: Utils.transStr(Constants.colorMain),
        inactiveColorPrimary: CupertinoColors.systemGrey,
        routeAndNavigatorSettings:
            RouteAndNavigatorSettings(initialRoute: '/management'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(context),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
            ? 0.0
            : kBottomNavigationBarHeight,
        hideNavigationBarWhenKeyboardShows: true,
        margin: EdgeInsets.all(0.0),
        popActionScreens: PopActionScreensType.all,
        bottomScreenMargin: 0.0,
        hideNavigationBar: _hideNavBar,
        decoration: NavBarDecoration(
            colorBehindNavBar: Colors.indigo,
            borderRadius: BorderRadius.circular(20.0)),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style17, // Choose the nav bar style with this property
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  final BuildContext menuScreenContext;
  final Widget child;
  const MainScreen({Key key, this.menuScreenContext, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: child));
  }
}
