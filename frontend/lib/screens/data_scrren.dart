import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class NavScreen extends StatefulWidget {
  final String token;
  const NavScreen({Key? key, required this.token}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
late String role;
  @override
  void initState() {
    super.initState();
    extractUserRole();
  }

void extractUserRole() {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.token);
    role = decodedToken['role'] ?? '';

    print('User Role: $role');
    print('User Role: $widget.name');
    print('Token: ${jsonEncode(decodedToken)}');
   
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Role: $role'),
          ],
        ),
      ),
    );
  }
}
