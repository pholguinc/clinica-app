import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';

class DrawerHeader extends StatefulWidget {
  @override
  State<DrawerHeader> createState() => _DrawerHeaderState();
}

class _DrawerHeaderState extends State<DrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorPrimary,
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/doctor-avatar.jpg')
                )
            ),
          ),
          const Text('Citas médicas', style: TextStyle(color: Colors.white, fontSize: 20)),
          const Text('doctor@ecodsalud.com', style: TextStyle(color: Colors.grey, fontSize: 14)),
        ],
      ),
    );
  }
}