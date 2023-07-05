import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/account.dart';


class AccountTitle extends StatelessWidget {
  final Account account;
  const AccountTitle({
    super.key,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},//Navigation
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                color: dLightContentColor,
                borderRadius: BorderRadius.circular(15)),
            child: Icon(account.icon, color: dprimaryColor),
          ),
          const SizedBox(width: 10),
          Text(
            account.title,
            style: const TextStyle(
              color: dprimaryColor,
              fontSize: dsmallFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Icon(CupertinoIcons.chevron_forward, color: Colors.grey.shade600),
        ],
      ),
    );
  }
}
