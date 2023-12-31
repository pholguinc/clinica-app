import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/screens/splash_screen.dart';

/*
Iniciamos la aplicación
 */

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Make the status bar transparent
      ),
    );
    return const MaterialApp(
        debugShowCheckedModeBanner: false, 
        home: SplashScreen(),
      );
  }

 
}
