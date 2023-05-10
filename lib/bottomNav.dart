// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:projectalpha/constants.dart';
import 'package:projectalpha/screens/analytics_screen/analytics.dart';
import 'package:projectalpha/screens/controls_screen/controls.dart';
import 'package:projectalpha/screens/home_screen/home.dart';
import 'package:projectalpha/screens/weather_screen/weather.dart';
import 'package:projectalpha/screens/settings_screen/settings.dart';
import 'package:sizer/sizer.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        screens: _buildScreens(),
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style9,
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
       Controls(),
      const WeatherPage(),
      const AnalyticsPage(),
      const SettingsPage()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home, size: 22.sp,),
        inactiveIcon: Icon(Icons.home, size: 22.sp,),
        title: ("Home"),
        activeColorPrimary: themeColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.adb),
        inactiveIcon: const Icon(Icons.adb),
        title: ("Controls"),
        activeColorPrimary: themeColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.cloud),
        inactiveIcon: const Icon(Icons.cloud),
        title: ("Weather"),
        activeColorPrimary: themeColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.analytics),
        inactiveIcon: const Icon(Icons.analytics),
        title: ("Analytics"),
        activeColorPrimary: themeColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        inactiveIcon: const Icon(Icons.settings),
        title: ("Settings"),
        activeColorPrimary: themeColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
}