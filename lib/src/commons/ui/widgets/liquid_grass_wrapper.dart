import 'dart:ui';

import 'package:flutter/material.dart';

class LiquidGlassWidget extends StatefulWidget {
  final Widget child;
  final double blur;

  const LiquidGlassWidget({required this.child, this.blur = 10, super.key});

  @override
  LiquidGlassWidgetState createState() => LiquidGlassWidgetState();
}

class LiquidGlassWidgetState extends State<LiquidGlassWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4))
          ..repeat(reverse: true);
    _animation = Tween<double>(begin: widget.blur, end: widget.blur + 5)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: _animation.value, sigmaY: _animation.value),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withAlpha((0.2).round()),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: Colors.white.withAlpha((0.2 * 255).round())),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white.withAlpha((0.1).round()),
                      blurRadius: 10,
                      spreadRadius: 1),
                ],
              ),
              child: widget.child,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
