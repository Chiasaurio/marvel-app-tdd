import 'package:flutter/material.dart';

Route crearRuta(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(milliseconds: 500),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //Specifyin animation
      final curvedAnimation =
          CurvedAnimation(parent: animation, curve: Curves.easeInOut);
      return SlideTransition(
        position: Tween<Offset>(
                begin: const Offset(-0.5, 1.0), end: const Offset(0, 0))
            .animate(curvedAnimation),
        child: page,
      );
    },
  );
}
