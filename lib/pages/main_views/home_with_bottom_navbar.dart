import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/configs/colors.dart';
import 'package:flutter_application_1/pages/main_views/home_screen.dart';
import 'package:flutter_application_1/pages/main_views/settings.dart';
import 'package:flutter_application_1/pages/main_views/messages.dart';

class HomeWithBottomNavBar extends StatefulWidget {
  static const pageName = '/homeWithBottomNavBar';
  const HomeWithBottomNavBar({Key? key}) : super(key: key);

  @override
  HomeWithBottomNavBarState createState() => HomeWithBottomNavBarState();
}


class HomeWithBottomNavBarState extends State<HomeWithBottomNavBar> {
  int currentIndex = 0;
  final screens = [
    HomeScreen(),
    MessagesScreen(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: kPrimaryBlue,
    ));
    return Scaffold(
      body: Center(
        child: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        iconSize: 40,
        unselectedLabelStyle:
            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        onTap: (index) => setState(() => currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kPrimaryBlue,
        selectedLabelStyle:
            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        unselectedItemColor: Colors.grey[500],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          )
        ],
      ),
    );
  }
}

