import 'package:flutter/material.dart';
import 'package:frontend/screens/search_screen.dart';
import 'package:frontend/widgets/home_content.dart';
import 'package:frontend/widgets/bottom_navigation.dart';

import 'account_screen.dart';
import 'date_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final List<Widget> screens = [
    const HomeContent(),
    const DateScreen(),
    const SearchScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: screens[currentIndex],
          ),
        ],
      ),
       bottomNavigationBar: BottomNavigation(
        currentIndex: currentIndex,
        onTabChange: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}