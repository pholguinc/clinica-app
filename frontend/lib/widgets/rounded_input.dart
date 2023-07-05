import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';

import 'input_container.dart';

class RoundedInput extends StatelessWidget {
  const RoundedInput({
    super.key,
    required this.icon, required this.hint,
  });

  final IconData icon;
  final String hint;

  @override
  Widget build(BuildContext context) {
    
    return InputContainer(
      child: TextField(
        cursorColor: logPrimaryColor,
        decoration: InputDecoration(
            icon: Icon(icon, color: logPrimaryColor),
            hintText: hint,
            border: InputBorder.none),
      ),
    );
  }
}
