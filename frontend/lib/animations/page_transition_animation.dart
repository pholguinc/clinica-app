import 'package:flutter/material.dart';

class PageTransitionAnimation extends PageRouteBuilder {
  final Widget enterWidget;

  PageTransitionAnimation(this.enterWidget)
      : super(
          opaque: false,
          pageBuilder: (context, animation,secondaryAnimation) => enterWidget,
          transitionDuration: const Duration(milliseconds: 900),
          transitionsBuilder: (context,animation,secondaryAnimation,child) {
                animation = CurvedAnimation(
                  parent: animation, 
                  curve: Curves.fastLinearToSlowEaseIn,
                  reverseCurve: Curves.fastOutSlowIn);
            return ScaleTransition(
              scale: animation, 
              alignment: const Alignment(0.0, 0.87),
              child: child,
            );
          },
         
        );
}
