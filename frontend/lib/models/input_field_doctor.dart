import 'package:flutter/material.dart';

class InputFieldDoctor extends StatelessWidget {
  final TextEditingController controller;
  final String fieldName;
  final IconData icon;
  final Color prefixIconColor;
  const InputFieldDoctor(
      {super.key,
      required this.controller,
      required this.fieldName,
      required this.icon,
      required this.prefixIconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: prefixIconColor,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          labelText: fieldName,
          labelStyle: TextStyle(color: prefixIconColor),
          prefixIcon: Icon(Icons.abc_sharp, color: prefixIconColor),
          border: InputBorder.none, 
          focusedBorder:
              InputBorder.none,
        ),
      ),
    );
  }
}
