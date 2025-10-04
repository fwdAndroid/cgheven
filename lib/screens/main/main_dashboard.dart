import 'dart:io';
import 'package:cgheven/screens/main/pages/favourite_screen.dart';
import 'package:cgheven/screens/main/pages/home_screen.dart';
import 'package:cgheven/screens/main/pages/profile_screen.dart';
import 'package:cgheven/screens/main/pages/setting_screen.dart';
import 'package:cgheven/utils/app_theme.dart';
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
    FavouriteScreen(),
    ProfileScreen(),
    SettingScreen(),
  ];

  final List<String> _labels = ["Home", "Favourite", "CGHEVEN", "Settings"];

  final List<IconData> _icons = [
    Icons.home_outlined,
    Icons.favorite,
    Icons.person,
    Icons.settings,
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
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: BottomNavigationBar(
            backgroundColor: AppTheme.darkBackground.withOpacity(0.6),
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedItemColor: const Color(0xff25b09f),
            unselectedItemColor: const Color(0xffd1d5db),
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: List.generate(_labels.length, (index) {
              final isActive = _currentIndex == index;
              return BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.all(8),
                  decoration: isActive
                      ? BoxDecoration(
                          color: const Color(
                            0xff25b09f,
                          ).withOpacity(0.15), // faint glow inside
                          borderRadius: BorderRadius.circular(
                            12,
                          ), // 👈 same radius as screenshot
                        )
                      : null,
                  child: Icon(
                    _icons[index],
                    size: 20,
                    color: isActive
                        ? const Color(0xff25b09f)
                        : const Color(0xffd1d5db),
                  ),
                ),
                label: _labels[index],
              );
            }),
          ),
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
