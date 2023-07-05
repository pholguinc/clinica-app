import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';

class DeleteAlert extends StatelessWidget {
  const DeleteAlert({
    Key? key,
  }) : super(key: key);

  void show(BuildContext context) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(10),
      backgroundColor: const Color.fromARGB(255, 88, 170, 21),
      duration: const Duration(seconds: 2),
      icon: const Icon(
        Icons.check,
        color: Colors.white,
      ),
      titleText: const Text(
        "¡Éxito!",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          color: Colors.white,
          fontFamily: "ShadowsIntoLightTwo",
        ),
      ),
      messageText: const Text(
        "El registro fue eliminado correctamente",
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
