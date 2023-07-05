import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../constants.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChange;

  const BottomNavigation({
    Key? key,
    required this.currentIndex,
    required this.onTabChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorPrimary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: GNav(
          backgroundColor: colorPrimary,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: colorPrimaryActive,
          gap: 8,
          selectedIndex: currentIndex,
          onTabChange: onTabChange,
          padding: const EdgeInsets.all(16.0),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.date_range_rounded,
              text: 'Citas',
            ),
            GButton(
              icon: Icons.search,
              text: 'Search',
            ),
            GButton(
              icon: Icons.person,
              text: 'Mi Cuenta',
            ),
          ],
        ),
      ),
    );
  }
}
