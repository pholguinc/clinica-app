import 'package:flutter/material.dart';

import '../constants.dart';



class AvatarCard extends StatelessWidget {
  const AvatarCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/user.png',
          width: 80,
          height: 80,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Flutter Code",
              style: TextStyle(
                fontSize: dBigFontSize,
                fontWeight: FontWeight.bold,
                color: dprimaryColor,
              ),
            ),
            Text(
              "Doctor",
              style: TextStyle(
                fontSize: dsmallFontSize,
                color: Colors.grey.shade600,
              ),
            )
          ],
        )
      ],
    );
  }
}
