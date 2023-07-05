import 'package:flutter/material.dart';

import '../constants.dart';

class InputContainer extends StatelessWidget {
  const InputContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width *0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: logPrimaryColor.withAlpha(50)
      ),
      child: child
    );
  }
}
