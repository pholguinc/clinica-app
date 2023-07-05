import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({super.key, required this.text, required this.onClicked});

  @override
  Widget build(BuildContext context) => Container(
        decoration: const ShapeDecoration(
          shape: StadiumBorder(),
          color: Colors.amberAccent,
        ),
        child: TextButton(
          onPressed: onClicked,
          child: const Text(
            'New Button Text', // Replace with your desired button text
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      );
}
