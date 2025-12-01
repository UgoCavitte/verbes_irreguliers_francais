import 'package:flutter/material.dart';

class AnimSlideRight extends PageRouteBuilder {
  final Widget page;

  AnimSlideRight({required this.page})
      : super(
          transitionDuration: const Duration(milliseconds: 400),

          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) => page,
          
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {

            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.fastOutSlowIn;

            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
