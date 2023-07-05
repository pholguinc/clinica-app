// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';

import 'input_container.dart';

class RoundedPasswordInput extends StatelessWidget {
  const RoundedPasswordInput({
    Key? key,
    required this.hint,
  }) : super(key: key);
  final String hint;



  @override
  Widget build(BuildContext context) {
    return  InputContainer(
      child: TextField(
        cursorColor: logPrimaryColor,
        decoration: InputDecoration(
          icon: const Icon(Icons.lock, color: logPrimaryColor),
          hintText: hint,
          border: InputBorder.none
        ),
      ),
    );
  }
}

