import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';

class ErrorLogin extends StatelessWidget {
  const ErrorLogin({
    Key? key,
  }) : super(key: key);

  void show(BuildContext context) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(10),
      backgroundColor: const Color.fromARGB(255, 235, 12, 12),
      duration: const Duration(seconds: 2),
      icon: const Icon(
        Icons.check_circle,
        color: Colors.white,
      ),
      titleText: const Text(
        "¡Error!",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          color: Colors.white,
          fontFamily: "ShadowsIntoLightTwo",
        ),
      ),
      messageText: const Text(
        "El email y/o password son incorrectos",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.white,
          fontFamily: "ShadowsIntoLightTwo",
        ),
      ),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
