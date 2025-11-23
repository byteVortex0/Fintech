import 'package:flutter/widgets.dart';

class BaseRoutes extends PageRouteBuilder {
  final Widget page;
  BaseRoutes({required this.page})
    : super(
        pageBuilder:
            (context, animation, secondaryAnimation) => Stack(children: [page]),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const double begin = 0.0;
          const double end = 1.0;
          final Tween<double> tween = Tween(begin: begin, end: end);

          final CurvedAnimation curve = CurvedAnimation(
            parent: animation,
            curve: Curves.linearToEaseOut,
          );

          return ScaleTransition(scale: tween.animate(curve), child: child);
        },
      );
}
