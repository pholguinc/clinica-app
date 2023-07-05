import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final Widget Function() route; // Parameter to accept the route screen

  const Navbar({Key? key, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Existing code

          InkWell(
            child: ListTile(
              leading: const Icon(Icons.account_circle_rounded),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        route(), // Use the route parameter to get the destination screen
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.ease;
                      final tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));
                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
          ),

          // Existing code

        ],
      ),
    );
  }
}
