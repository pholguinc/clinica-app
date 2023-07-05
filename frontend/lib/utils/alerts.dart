import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';

void showDeleteSuccessNotification(BuildContext context, String message, Color bgcolor) {
  const Color successColor = Color.fromARGB(255, 88, 170, 21);
  const Color errorColor = Colors.red;

  Color notificationColor;

  if (bgcolor == successColor) {
    notificationColor = const Color.fromARGB(255, 88, 170, 21);
  } else {
    notificationColor = errorColor;
  }

  Flushbar(
    flushbarPosition: FlushbarPosition.TOP,
    borderRadius: BorderRadius.circular(10),
    backgroundColor: notificationColor,
    duration: const Duration(seconds: 2),
    icon: Icon(
      bgcolor == successColor ? Icons.check_circle : Icons.close,
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
    messageText: Text(
      message,
      style: const TextStyle(
        fontSize: 16.0,
        color: Colors.white,
        fontFamily: "ShadowsIntoLightTwo",
      ),
    ),
  ).show(context);
}
