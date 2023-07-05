import 'package:flutter/material.dart';

class TextFieldForm extends StatelessWidget {
  final TextEditingController controller;
  final String fieldName;
  final IconData icon;
  final Color prefixIconColor;
  final String textValidator;

  const TextFieldForm({
    Key? key,
    required this.controller,
    required this.fieldName,
    required this.icon,
    required this.prefixIconColor, 
    required this.textValidator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return textValidator;
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: fieldName,
        labelStyle: TextStyle(color: prefixIconColor),
        prefixIcon: Icon(icon, color: prefixIconColor),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: prefixIconColor),
        ),
      ),
    );
  }
}
