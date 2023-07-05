import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Account {
  final String title;
  final String route;
  final IconData icon;

  Account({
    required this.title,
    required this.route,
    required this.icon,
  });
}

final List<Account> accounts = [
  Account(
    title: "Personal Data",
    route: "/",
    icon: CupertinoIcons.person_fill,
  ),
  Account(
    title: "Settings",
    route: "/",
    icon: Icons.settings,
  ),
  Account(
    title: "E-statements",
    route: "/",
    icon: CupertinoIcons.doc_fill,
  ),
  Account(
    title: "Code",
    route: "/",
    icon: CupertinoIcons.heart_fill,
  ),
];
