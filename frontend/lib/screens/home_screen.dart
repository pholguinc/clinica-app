import 'package:flutter/material.dart';
import 'package:frontend/screens/search_screen.dart';
import 'package:frontend/widgets/home_content.dart';
import 'package:frontend/widgets/bottom_navigation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'account_screen.dart';
import 'date_screen.dart';

class HomeScreen extends StatefulWidget {
  final String token;
  const HomeScreen({Key? key, required this.token}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late String role;
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    extractUserRole();
    screens = [
      HomeContent(role: role),
      const DateScreen(),
      const SearchScreen(),
      const AccountScreen(),
    ];
  }

void extractUserRole() {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.token);
    role = decodedToken['role'] ?? '';

    print('User Role: $role');
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: screens[0],
          ),
        ],
      ),
       bottomNavigationBar: BottomNavigation(
        currentIndex: 0,
        onTabChange: (index) {
          setState(() {
            
          });
        },
      ),
    );
  }
}