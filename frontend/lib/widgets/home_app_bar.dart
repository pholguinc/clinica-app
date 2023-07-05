import 'package:flutter/material.dart';

import '../constants.dart';
import '../screens/profile_screen.dart';

class HomeAppBar extends StatelessWidget {
  final String appBarTitle;
  final String userName;

  const HomeAppBar({
    Key? key,
    required this.appBarTitle,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        margin: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Text(
              appBarTitle,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            Text(
              userName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        InkWell(
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: IconButton(
              icon: Image.asset(
                'assets/images/user.png',
                width: 40,
                height: 40,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 300),
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return const ProfileScreen(); 
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = const Offset(1.0, 0.0);
                      var end = Offset.zero;
                      var curve = Curves.ease;
                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        )
      ],
      backgroundColor: colorPrimary,
    );
  }
}