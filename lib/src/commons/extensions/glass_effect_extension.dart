import 'package:flutter/material.dart';

import '../ui/widgets/glass_effect.dart';

extension GlassExtension on Widget {
  Widget withGlassEffect({
    double blur = 10,
    double opacity = 0.3,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(20)),
  }) {
    return GlassEffect(
      blur: blur,
      opacity: opacity,
      borderRadius: borderRadius,
      child: this,
    );
  }
}
