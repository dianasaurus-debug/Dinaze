import 'package:flutter/material.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';
import 'package:flutter_cash_waqf/view/pages/history_screen.dart';
import 'package:flutter_cash_waqf/view/pages/home_screen.dart';
import 'package:flutter_cash_waqf/view/pages/profile_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainScreen extends StatelessWidget {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: [
          HomeScreen(),
          HistoryScreen(),
          ProfileScreen(),
        ],
        items: [
          PersistentBottomNavBarItem(
            icon: FaIcon(FontAwesomeIcons.home, size: 20.0),
            title: "Beranda",
            activeColorPrimary: Colors.white,
            activeColorSecondary: Constant.bwiGreenColor,
            inactiveColorPrimary: Colors.white,
          ),
          PersistentBottomNavBarItem(
            icon: FaIcon(FontAwesomeIcons.history, size: 20.0),
            title: "Riwayat",
            activeColorPrimary: Colors.white,
            activeColorSecondary: Constant.bwiGreenColor,
            inactiveColorPrimary: Colors.white,
          ),
          PersistentBottomNavBarItem(
            icon: Icon(FontAwesomeIcons.solidUserCircle, size: 20.0),
            title: "Profil",
            activeColorPrimary: Colors.white,
            activeColorSecondary: Constant.bwiGreenColor,
            inactiveColorPrimary: Colors.white,
          ),
        ],
        confineInSafeArea: true,
        backgroundColor: Constant.bwiGreenColor,
        handleAndroidBackButtonPress: false,
        resizeToAvoidBottomInset: true,
        hideNavigationBarWhenKeyboardShows: true,
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        navBarStyle: NavBarStyle.style10,
      ),
    );
  }
}
