import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class NavScreen extends StatefulWidget {
  final token;
  const NavScreen({super.key, required this.token});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  late String email;

  @override
  void initState() {
    super.initState();
  

    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
            Text('ff')
          ],
        ),
      ),
    );
  }
}