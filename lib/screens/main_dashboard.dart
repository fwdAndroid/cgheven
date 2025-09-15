import 'dart:io';
import 'package:cgheven/screens/favourite/favourite_screen.dart';
import 'package:cgheven/screens/pages/discovery_screen.dart';
import 'package:cgheven/screens/pages/home_screen.dart';
import 'package:cgheven/screens/pages/profile_screen.dart';
import 'package:cgheven/screens/pages/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainDashboard extends StatefulWidget {
  final int initialPageIndex;

  const MainDashboard({super.key, this.initialPageIndex = 0});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    DiscoveryScreen(),
    FavouriteScreen(),
    // CommunityScreen(),
    ProfileScreen(),
    SettingScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialPageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showExitDialog(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xff171d27),
          selectedItemColor: const Color(0xff25b09f),
          unselectedItemColor: const Color(0xffd1d5db),
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true, // 👈 Always show labels
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 25),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore, size: 25), // 👈 Discovery icon
              label: "Discovery",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, size: 25),
              label: "Favourites",
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.groups, size: 25), // 👈 Community icon
            //   label: "Community",
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 25),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: 25),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _showExitDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Do you want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
