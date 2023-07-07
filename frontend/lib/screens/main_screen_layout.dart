import 'package:flutter/material.dart';
import 'package:frontend/screens/search_screen.dart';
import '../widgets/home_content.dart';
import 'account_screen.dart';
import 'date_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
   int currentIndex = 0;
  final List<Widget> screens = [
    const DateScreen(),
    const SearchScreen(),
    const AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      body: Container(),
      
    );
  }
  

}