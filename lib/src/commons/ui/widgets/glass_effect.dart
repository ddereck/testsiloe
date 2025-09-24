import 'dart:ui';
import 'package:flutter/material.dart';

class GlassEffect extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final BorderRadius borderRadius;

  const GlassEffect({
    super.key,
    required this.child,
    this.blur = 10,
    this.opacity = 0.3,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withAlpha((opacity * 255).round()),
            borderRadius: borderRadius,
            border: Border.all(color: Colors.white.withAlpha((0.2 * 255).round())),
          ),
          child: child,
        ),
      ),
    );
  }
}
