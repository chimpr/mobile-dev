import 'package:flutter/material.dart';

Route createRoute(Widget page, int direction) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      Offset begin;

      if (direction == 1) {
        begin = Offset(-1.0, 0.0);
      }
      else if (direction == 2) {
        begin = Offset(1.0, 0.0);
      }
      else {
        begin = Offset(1.0, 0.0);
      }

      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
