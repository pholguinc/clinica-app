import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/screens/profile_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      
      iconTheme: const IconThemeData(color: Colors.white),
      title: Container(
        margin: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            const Text(
              'Bienvenido',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            Text(
              title,
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
      actions: <Widget>[
        Container(
          margin: const EdgeInsets.only(right: 16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
            child: IconButton(
              icon: Image.asset(
                'assets/images/user.png',
                height: 40,
                width: 40,
              ),
              onPressed: () {},
              iconSize: 35,
            ),
          ),
        ),
      ],
      backgroundColor: colorPrimary,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
